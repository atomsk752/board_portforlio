package org.atomsk.domain;

import lombok.Data;

@Data
public class PageParam {

	private Integer bno, page, display, start, end, total;
	private Boolean next, prev;
	private String[] types;
	private String keyword, type;
	
	
	public PageParam() {
		
		this.page = 1;
		this.display = 10;
	}
	
	public PageParam(int page, int display) {
		this.page = page;
		this.display = display;
	}
	
	public void setTotal(int total) {
		this.total = total;
		this.end = (int)(Math.ceil(this.page/10.0))*10;
		this.start = this.end - 9;
		if((this.end)*10 >=this.total) {
			this.end = (int)Math.ceil(this.total/this.display);
			this.next = false;
		}else {
			this.next = true;
		}
		this.prev = this.start!= 1;
	}//end total
	
	public int getSkip() {
		return (this.page-1) * this.display;
	}//end skip
}
