package org.atomsk.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	
	private Integer del;
	private Long bno;
	private String title, writer, content;
	private Date regdate, updatedate;
	private int replyCnt;
	
	private List<BoardAttachVO> attachList;
	
}


//public class BoardVO {
//	private Integer bno, bhits, blike, bdislike, bdel;
//	private String btitle, bcontent;
//	private Date bregdate, bupdatedate;
//
//}