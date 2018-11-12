package org.atomsk.service;

import java.util.List;

import org.atomsk.domain.BoardAttachVO;
import org.atomsk.domain.BoardVO;
import org.atomsk.domain.PageParam;
import org.atomsk.mapper.BoardAttachMapper;
import org.atomsk.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements BoardService {

	
	@Setter(onMethod_=@Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private BoardAttachMapper attachMapper;
	
	@Override
	public List<BoardVO> getList(PageParam pageParam) {
		// TODO Auto-generated method stub
		log.info("get list.........");
		return mapper.getList(pageParam);
	}

	@Transactional
	@Override
	public int register(BoardVO boardVO) {
		
		log.info("register..." + boardVO);
		
		int result = mapper.insertSelectKey(boardVO);
		
		if (boardVO.getAttachList()==null || boardVO.getAttachList().size() <= 0) {
			return result;
		}
		for (BoardAttachVO attach : boardVO.getAttachList()) {
			attach.setBno(boardVO.getBno());
			attachMapper.insert(attach);
		}
		return result;
	}

	@Override
	public BoardVO get(Long bno) {
		// TODO Auto-generated method stub
		return mapper.read(bno);
	}

	@Override
	public boolean remove(BoardVO boardVO) {
		// TODO Auto-generated method stub
		return mapper.delete(boardVO)==1;
	}

	@Override
	public boolean modify(BoardVO boardVO) {
		
		log.info("modify......." + boardVO);
		
		return mapper.update(boardVO) == 1;
	}

	@Override
	public int getTotal(PageParam pageParam) {
		// TODO Auto-generated method stub
		return mapper.count(pageParam);
	}



}
