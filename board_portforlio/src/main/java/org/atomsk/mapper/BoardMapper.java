 package org.atomsk.mapper;

import java.util.List;

import org.atomsk.domain.BoardVO;

public interface BoardMapper {
	
	public List<BoardVO> getList();
	
	public int register(BoardVO boardVO);
	
	public BoardVO read(Long bno);
	
	public int delete(BoardVO boardVO);
	
	public int update(BoardVO boardVO);

}
