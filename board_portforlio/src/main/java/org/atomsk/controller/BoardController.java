package org.atomsk.controller;

import org.atomsk.domain.BoardVO;
import org.atomsk.service.BoardService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
	public void list(Model model) {
		log.info("list");
		
		model.addAttribute("list",service.getList());
	}
	
	@PostMapping("/register")
	public String register(BoardVO boardVO, RedirectAttributes rttr) {
		log.info("register:..."+ boardVO);
		service.register(boardVO);
		rttr.addFlashAttribute("result", boardVO.getBno());
		return "redirect:/board/list";
	}
	
	@GetMapping("/get")
	public void get(@RequestParam("bno") Long bno, Model model) {
		log.info("/get");
		model.addAttribute("boardVO",service.get(bno));
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO boardVO, RedirectAttributes rttr) {
		log.info("modify: "+ boardVO);
		
		if (service.modify(boardVO)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String remove(BoardVO boardVO, RedirectAttributes rttr) {
		log.info("remove: "+ boardVO);
		
		if (service.remove(boardVO)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}
	
}
