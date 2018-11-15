package org.atomsk.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.atomsk.domain.BoardAttachVO;
import org.atomsk.domain.BoardVO;
import org.atomsk.domain.PageParam;
import org.atomsk.service.BoardService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

	private BoardService service;
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		
		if (attachList== null || attachList.size()==0) {
			return;
		}
		log.info("delete attach files....");
		log.info(attachList);
		
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("C:\\upload\\"+attach.
						getUploadPath()+"\\" + attach.getUuid()+"_"+ attach.getFileName());
				
				Files.deleteIfExists(file);
				
				if (Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\"+attach.
							getUploadPath()+"\\s_"+ attach.getUuid()+"_"+ attach.getFileName());
					
					Files.delete(thumbNail);
				}
				
			}catch(Exception e) {
				log.error("delete file error" + e.getMessage());
			}//end catch
		});//end foreach
		
	}
	

	
	@GetMapping(value="/getAttachList",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		
		log.info("getAttachList" +bno);
		
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
		
	}
	
	@GetMapping("/list")
	public void list(Model model, @ModelAttribute("pageObj") PageParam pageParam) {
		log.info("list");
		pageParam.setTotal(service.getTotal(pageParam));
		model.addAttribute("list",service.getList(pageParam));
	}
	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(BoardVO boardVO, RedirectAttributes rttr) {
		
		log.info("=============================");
		log.info("register:..."+ boardVO);
		
		if (boardVO.getAttachList()!=null) {
			boardVO.getAttachList().forEach(attach -> log.info(attach));
		}
		
		int result = service.register(boardVO);
		
		rttr.addFlashAttribute("result", result==1?"SUCCESS":"FAIL");
		return "redirect:/board/list";
	}
	
	
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register() {
	}
	
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("pageObj") PageParam pageParam, Model model) {
		log.info("/get or modify");
		model.addAttribute("board",service.get(bno));
	}
	
	@PreAuthorize("principal.username == #boardVO.writer")
	@PostMapping("/modify")
	public String modify(BoardVO boardVO, @ModelAttribute("pageObj") PageParam pageParam, RedirectAttributes rttr) {
		log.info("modify: "+ boardVO);
		
		if (service.modify(boardVO)) {
			rttr.addFlashAttribute("result", "SUCCESS");
		}
		rttr.addAttribute("page",pageParam.getPage());
		rttr.addAttribute("bno",boardVO.getBno());
		rttr.addAttribute("display",pageParam.getDisplay());
		rttr.addAttribute("type",pageParam.getType());
		rttr.addAttribute("keyword",pageParam.getKeyword());
		return "redirect:/board/get";
	}
	
	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove")
	public String remove(BoardVO boardVO, @ModelAttribute("pageObj") PageParam pageParam,
			RedirectAttributes rttr, String writer) {
		log.info("remove: "+ boardVO);
		
		//attached files
		List<BoardAttachVO> attachList = service.getAttachList(boardVO.getBno());
		
		if (service.remove(boardVO)) {
			deleteFiles(attachList);
			
			rttr.addFlashAttribute("result", "SUCCESS");
		}
		rttr.addAttribute("page",pageParam.getPage());
		rttr.addAttribute("bno",boardVO.getBno());
		rttr.addAttribute("display",pageParam.getDisplay());
		rttr.addAttribute("type",pageParam.getType());
		rttr.addAttribute("keyword",pageParam.getKeyword());
		return "redirect:/board/list";
	}
	
}
