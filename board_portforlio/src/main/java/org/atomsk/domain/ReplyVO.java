package org.atomsk.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	private Long rno, bno;
	private String reply, replyer;
	private Date replyDate;
	private Date replyupdatedate;
	private Integer replydel;

}
