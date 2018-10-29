package org.atomsk.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {
	private Integer uenabled;
	private String userid, userpw, unick, urole;
	private Date uregdate, uupdatedate;

}
