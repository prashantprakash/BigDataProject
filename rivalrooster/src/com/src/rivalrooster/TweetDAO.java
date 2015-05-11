package com.src.rivalrooster;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

public class TweetDAO {

	/*
	 * 
	 * 
	 */
	public UserGraphVO last6MonthsUsage(String pageName) {
		UserGraphVO graphTotalVO = new UserGraphVO();
		Connection conn = null;
		try {
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rivalrooster?" + "user=root&password=root");
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select DATE_FORMAT(CreatedTime,'%y-%m') , count(*) as tweetcount , "
					+ "sum(retweetcount) , sum(favouritecount) from tweets where " + "pageName = '" + pageName
					+ "' group by DATE_FORMAT(CreatedTime,'%y-%m')"
					+ "order by DATE_FORMAT(CreatedTime,'%y-%m') desc limit 6;");
			while (rs.next()) {
				graphTotalVO.getXticks().add(rs.getString(1));
				graphTotalVO.getValues1().add(rs.getInt(2));
				graphTotalVO.getValues2().add(rs.getInt(3));
				graphTotalVO.getValues3().add(rs.getInt(4));
			}
		} catch (Exception ex) {

		} finally {

		}

		return graphTotalVO;
	}

	/*
	 * 
	 * 
	 * 
	 */

	public GraphVO hours24Usage(String pageName, Date currdate) {
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
			ResultSet rs = stmt.executeQuery("SELECT case when ( Hour(createdtime) <= 12) then "
					+ "CONCAT(Hour(createdtime),' AM') when ( Hour(createdtime) >12 ) "
					+ "then CONCAT(Hour(createdtime)-12,' PM') else Hour(createdtime) end "
					+ "AS hour, count(*) AS count ,Hour(createdtime) as hr FROM  tweets "
					+ "WHERE  DATE_FORMAT(createdtime,'%y-%m-%d') = date_format('2015-05-10','%y-%m-%d') "
					+ "and pagename = '" + pageName + "' group by hour order by Hour(createdtime) asc ;");

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

	public GraphVO locationStats(String pageName) {
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
			ResultSet rs = stmt.executeQuery("select location, count(*) as count from tweetreplies "
					+ "where pagename='" + pageName + "' and location is not null "
					+ "group by location order by count desc limit 5;");
			while (rs.next()) {
				graphVO.getXticks().add(rs.getString(1));
				graphVO.getValues().add(rs.getInt(2));
			}
		} catch (Exception ex) {

		} finally {

		}

		return graphVO;
	}

	public List<Integer> getSentiments(String pageName) {

		Connection conn = null;
		List<Integer> sentList = new ArrayList<Integer>();
		try {
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rivalrooster?" + "user=root&password=root");
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select count(*) from tweetreplies where sentiment='positive' and "
					+ "pagename ='" + pageName + "' union all select count(*) from "
					+ "tweetreplies where sentiment ='negative'and pagename ='" + pageName + "';");
			while (rs.next()) {
				sentList.add(rs.getInt(1));
			}

		} catch (Exception ex) {

		} finally {

		}
		return sentList;

	}

	/*
	 * 
	 * 
	 * 
	 */
	public double getscore(String pageName) {
		Connection conn = null;
		List<Integer> ints = new ArrayList<Integer>();
		try {
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rivalrooster?" + "user=root&password=root");
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select count(*) + sum(retweetcount) + sum(favouritecount)"
					+ "from tweets where pageName = '" + pageName + "' union all select "
					+ "Max(temp.count) from (select count(*) + "
					+ "sum(retweetcount) + sum(favouritecount) as count from tweets " + "group by pageName) as temp;");
			while (rs.next()) {
				ints.add(rs.getInt(1));

			}

		} catch (Exception ex) {

		} finally {

		}
		return (ints.get(0) / (double)ints.get(1)) *100;
	}
	
	/*
	 * 
	 * 
	 * 
	 * 
	 */
	public GraphVO topkUsers(String pageName, int k) {
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
			ResultSet rs = stmt.executeQuery("select ScreenName , count(*) as count from tweetreplies  "
					+ "where pagename ='"+pageName+"' group by ScreenName order by count desc limit 5;");
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
	public List<String> getTags() {
		Connection conn = null;
		List<String> tags = new ArrayList<String>();

		try {
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rivalrooster?" + "user=root&password=root");
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select distinct pagename from tweets;");
			while (rs.next()) {
				tags.add(rs.getString(1));

			}

		} catch (Exception ex) {

		} finally {

		}
		return tags;
	}
}
