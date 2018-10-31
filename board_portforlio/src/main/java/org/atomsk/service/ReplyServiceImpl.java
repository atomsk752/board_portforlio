package org.atomsk.service;

import java.util.List;

import org.atomsk.domain.PageParam;
import org.atomsk.domain.ReplyVO;
import org.atomsk.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Service
@Log4j
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {
	
	@Setter(onMethod_=@Autowired)
	private ReplyMapper mapper;

	@Override
	public int register(ReplyVO replyVO) {

		log.info("register..." + replyVO);
		
		return  mapper.insert(replyVO);
	}

	@Override
	public ReplyVO get(Long rno) {
		
		log.info("get......"+rno);
		
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO replyVO) {

		log.info("modify...." + replyVO);
		
		return mapper.update(replyVO);
	}

	@Override
	public int remove(Long rno) {
		
		log.info("remove...." + rno);
		
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(PageParam pageParam, Long bno) {

		log.info("get Reply List of a Board"+bno);
		
		return mapper.getListWithPaging(pageParam, bno);
	}

}