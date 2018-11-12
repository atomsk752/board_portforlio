 package org.atomsk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.atomsk.domain.BoardVO;
import org.atomsk.domain.PageParam;

public interface BoardMapper {
	
	public List<BoardVO> getList(PageParam pageParam);
	
	public int register(BoardVO boardVO);
	
	public BoardVO read(Long bno);
	
	public int delete(BoardVO boardVO);
	
	public int update(BoardVO boardVO);
	
	public int count(PageParam pageParam);
	
	public Integer insertSelectKey(BoardVO boardVO);
	
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);

}
