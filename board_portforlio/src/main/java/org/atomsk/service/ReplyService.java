package org.atomsk.service;

import java.util.List;

import org.atomsk.domain.PageParam;
import org.atomsk.domain.ReplyPageDTO;
import org.atomsk.domain.ReplyVO;

public interface ReplyService {
	
	public int register(ReplyVO replyVO);
	
	public ReplyVO get(Long rno);
	
	public int modify(ReplyVO replyVO);
	
	public int remove(Long rno);
	
	public List<ReplyVO> getList(PageParam pageParam, Long bno);
	
	public ReplyPageDTO getListPage(PageParam pageParam, Long bno);

}
