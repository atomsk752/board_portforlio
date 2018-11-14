package org.atomsk.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	private boolean enabled;
	private String userid, userpw, userName;
	private Date regDate, updateDate;
	private List<AuthVO> authList;
	

}
