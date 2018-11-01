package org.atomsk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.atomsk.domain.PageParam;
import org.atomsk.domain.ReplyVO;

public interface ReplyMapper {
	
	public int insert(ReplyVO replyVO);
	
	public ReplyVO read(Long bno);
	
	public int update(ReplyVO reply);
	
	public int delete(Long bno);
	
	public List<ReplyVO> getListWithPaging(
			@Param("pageObj") PageParam pageParam,
			@Param("bno") Long bno);
	
	public int getCountByBno(Long bno);
	
	
	

}
