package org.atomsk.controller;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

public class DbTests {
	
	private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
	private static final String URL = "jdbc:mysql://10.10.10.101:3306/atomsk?serverTimezone=UTC&useSSL=false";
	private static final String USER = "atomsk";
	private static final String PW = "12345678";
	
	@Test
	public void testConnection() throws Exception{
		
		Class.forName(DRIVER);
		
		Connection con = DriverManager.getConnection(URL, USER, PW);
		
		System.out.println(con);
	}
	

}
