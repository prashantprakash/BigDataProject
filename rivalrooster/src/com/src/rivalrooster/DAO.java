package com.src.rivalrooster;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;

/*
 * Author : Prashant Prakash
 * Creation Date: 8th May 2015
 * Description:  This class is used to access database
 */
public class DAO {
	/*
	 * 
	 * 
	 */
	public GraphVO last6MonthsUsage(String pageID) {
		Connection conn = null;
		GraphVO graphVO = new GraphVO();
		try {
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rivalrooster?" + "user=root&password=root");
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt
					.executeQuery("select DATE_FORMAT(created_time,'%y-%m-%d') , count(*) from page_post where page_id='"
							+ pageID + "' group by created_time ; ");
			while (rs.next()) {
				graphVO.getXticks().add(rs.getString(1));
				graphVO.getValues().add(rs.getInt(2));
			}
		} catch (Exception ex) {

		} finally {

		}

		return graphVO;
	}

	/*
	 * 
	 * 
	 * 
	 */
	public GraphVO hours24Usage(String pageID, Date currdate) {
		Connection conn = null;
		GraphVO graphVO = new GraphVO();
		String prevDate = null;
		String currDate = null;
		try {
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rivalrooster?" + "user=root&password=root");
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT Hour(created_time) AS hour, count(*) AS count "
					+ "FROM   page_post WHERE  created_time BETWEEN '" + prevDate + "' and '" + currDate + "'"
					+ "GROUP  BY hour ORDER  BY hour");
			while (rs.next()) {
				graphVO.getXticks().add(rs.getString(1));
				graphVO.getValues().add(rs.getInt(2));
			}
		} catch (Exception ex) {

		} finally {

		}

		return graphVO;
	}

	/*
	 * 
	 * 
	 * 
	 * 
	 */
	public GraphVO topkUsers(String pageID, int k) {
		Connection conn = null;
		GraphVO graphVO = new GraphVO();
		try {
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rivalrooster?" + "user=root&password=root");
			Statement stmt = conn.createStatement();

		} catch (Exception ex) {

		} finally {

		}
		return graphVO;

	}
	/*
	 * 
	 * 
	 * 
	 */
	public int getscore(String pageID) {
		int score = 0;
		
		return score;
	}

}
