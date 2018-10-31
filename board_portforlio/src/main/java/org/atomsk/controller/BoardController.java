package org.atomsk.controller;

import org.atomsk.domain.BoardVO;
import org.atomsk.domain.PageParam;
import org.atomsk.service.BoardService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

	private BoardService service;
	
	@GetMapping("/list")
	public void list(Model model, @ModelAttribute("pageObj") PageParam pageParam) {
		log.info("list");
		pageParam.setTotal(service.getTotal(pageParam));
		model.addAttribute("list",service.getList(pageParam));
	}
	
	@PostMapping("/register")
	public String register(BoardVO boardVO, RedirectAttributes rttr) {
		log.info("register:..."+ boardVO);
		
		int result = service.register(boardVO);
		
		rttr.addFlashAttribute("result", result==1?"SUCCESS":"FAIL");
		return "redirect:/board/list";
	}
	@GetMapping("/register")
	public void register() {
	}
	
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("pageObj") PageParam pageParam, Model model) {
		log.info("/get or modify");
		model.addAttribute("board",service.get(bno));
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO boardVO, @ModelAttribute("pageObj") PageParam pageParam, RedirectAttributes rttr) {
		log.info("modify: "+ boardVO);
		
		if (service.modify(boardVO)) {
			rttr.addFlashAttribute("result", "SUCCESS");
		}
		rttr.addAttribute("page",pageParam.getPage());
		rttr.addAttribute("bno",boardVO.getBno());
		rttr.addAttribute("display",pageParam.getDisplay());
		return "redirect:/board/get";
	}
	
	@PostMapping("/remove")
	public String remove(BoardVO boardVO, @ModelAttribute("pageObj") PageParam pageParam, RedirectAttributes rttr) {
		log.info("remove: "+ boardVO);
		
		if (service.remove(boardVO)) {
			rttr.addFlashAttribute("result", "SUCCESS");
		}
		rttr.addAttribute("page",pageParam.getPage());
		rttr.addAttribute("bno",boardVO.getBno());
		rttr.addAttribute("display",pageParam.getDisplay());
		return "redirect:/board/list";
	}
	
}
