package org.atomsk.service;

import java.util.List;

import org.atomsk.domain.BoardVO;

public interface BoardService {
	
	public List<BoardVO> getList();
	
	public int register(BoardVO boardVO);
	
	public BoardVO get(Long bno);
	
	public boolean remove(BoardVO boardVO);
	
	public boolean modify(BoardVO boardVO);
	

}
