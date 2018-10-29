package org.atomsk.controller;

import org.atomsk.domain.BoardVO;
import org.atomsk.mapper.BoardMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	
	@Setter(onMethod_=@Autowired)
	private BoardMapper mapper;
	
	@Test
	public void testRegister() {
		
		BoardVO boardVO = new BoardVO();
		boardVO.setTitle("03테스트title");
		boardVO.setContent("03테스트Content");
		boardVO.setWriter("03테스트writer");
		log.info(mapper.register(boardVO));
	}
	
//	@Test
//	public void testgetList() {
//		mapper.getList().forEach(board -> log.info(board));
//	}
	
	@Test
	public void testRead() {
		BoardVO boardVO = mapper.read(10L);
		log.info(boardVO);
	}
	
	@Test
	public void testDelete() {
		BoardVO boardVO = new BoardVO();
		boardVO.setBno(8);
		log.info(mapper.delete(boardVO));
	}
	@Test
	public void testUpdate() {
		BoardVO boardVO = new BoardVO();
		boardVO.setBno(8);
		boardVO.setTitle("01죄송");
		boardVO.setContent("01asd");
		boardVO.setWriter("01asda");
		log.info(mapper.update(boardVO));
	}

}
