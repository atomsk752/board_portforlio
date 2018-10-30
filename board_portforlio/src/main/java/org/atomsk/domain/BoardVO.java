package org.atomsk.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	
	private Integer bno, del;
	private String title, writer, content;
	private Date regdate, updatedate;
	
}


//public class BoardVO {
//	private Integer bno, bhits, blike, bdislike, bdel;
//	private String btitle, bcontent;
//	private Date bregdate, bupdatedate;
//
//}