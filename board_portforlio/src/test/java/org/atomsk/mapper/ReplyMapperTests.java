package org.atomsk.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.atomsk.domain.PageParam;
import org.atomsk.domain.ReplyVO;
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
public class ReplyMapperTests {
	
	private Long[] bnoArr = {16622L, 16621L, 16609L, 16608L, 16607L};
	
	@Setter(onMethod_=@Autowired)
	private ReplyMapper mapper;
	

	@Test
	public void testList() {
		
		PageParam pageParam = new PageParam();
		
		List<ReplyVO> replies = mapper.getListWithPaging(pageParam, bnoArr[0]);
		
		replies.forEach(reply -> log.info(reply));
		
	}
	
	@Test
	public void testUpdate() {
		Long targetRno =2L;
		
		ReplyVO replyVO = mapper.read(targetRno);
		
		replyVO.setReply("updateeeee");
		
		int count = mapper.update(replyVO);
		
		log.info("update count: " + count);
	}
	
	
	@Test
	public void testRead() {
		
		Long targetRno = 2L;
		
		ReplyVO replyVO = mapper.read(targetRno);
		
		log.info(replyVO);
	}
	
	
	@Test
	public void testCreate() {
		
		IntStream.rangeClosed(1, 10).forEach(i -> {
			
			ReplyVO replyVO = new ReplyVO();
			
			replyVO.setBno(bnoArr[i % 5]);
			replyVO.setReply("댓글 테스트" + i);
			replyVO.setReplyer("replyer"+ i);
			
			mapper.insert(replyVO);
			
		});
	}
	
	
	@Test
	public void testMapper() {
		log.info(mapper);
	}

}
