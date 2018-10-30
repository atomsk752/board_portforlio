package org.atomsk.service;

import java.util.List;

import org.atomsk.domain.BoardVO;
import org.atomsk.domain.PageParam;
import org.atomsk.mapper.BoardMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

	private BoardMapper mapper;
	
	@Override
	public List<BoardVO> getList(PageParam pageParam) {
		// TODO Auto-generated method stub
		log.info("get list.........");
		return mapper.getList(pageParam);
	}

	@Override
	public int register(BoardVO boardVO) {
		// TODO Auto-generated method stub
		return mapper.register(boardVO);
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
	public int count() {
		// TODO Auto-generated method stub
		return mapper.count();
	}



}
