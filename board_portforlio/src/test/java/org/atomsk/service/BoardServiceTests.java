package org.atomsk.service;

import static org.junit.Assert.assertNotNull;

import org.atomsk.domain.BoardVO;
import org.atomsk.domain.PageParam;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BoardServiceTests {
	
	@Setter(onMethod_= @Autowired )
	private BoardService service;
	
	@Test
	public void testExist(){
		
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	public void testGetList(PageParam pageParam ) {
		service.getList(pageParam).forEach(board -> log.info(board));
	}
	
	@Test
	public void testUpdate() {
		
		BoardVO boardVO = new BoardVO();
		boardVO.setBno(8);

		if (boardVO == null) {
			return;
		}
		
		boardVO.setTitle("03 update");
		boardVO.setContent("03테스트update");
		boardVO.setWriter("03테스트update");
		log.info("Modify RESULT" + service.modify(boardVO));
		
	}
	

}
