package com.src.rivalrooster;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

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
	public UserGraphVO last6MonthsUsage(String pageID) {
		UserGraphVO graphTotalVO = new UserGraphVO();
		GraphVO postUsage = last6MonthspostUsage(pageID);
		GraphVO commentUsage = last6MonthsCommentUsage(pageID);

		graphTotalVO.getXticks().addAll(postUsage.getXticks());
		graphTotalVO.getValues1().addAll(postUsage.getValues());
		graphTotalVO.getValues2().addAll(commentUsage.getValues());
		return graphTotalVO;

	}

	/*
	 * 
	 * 
	 * 
	 */
	private GraphVO last6MonthspostUsage(String pageID) {
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
			ResultSet rs = stmt.executeQuery("select DATE_FORMAT(created_time,'%y-%m') , count(*) from page_post "
					+ "where page_id='" + pageID + "' group by DATE_FORMAT(created_time,'%y-%m') "
					+ "order by DATE_FORMAT(created_time,'%y-%m') desc limit 6; ");
			while (rs.next()) {
				graphVO.getXticks().add(rs.getString(1));
				graphVO.getValues().add(rs.getInt(2));
			}
		} catch (Exception ex) {

		} finally {

		}

		return graphVO;
	}

	private GraphVO last6MonthsCommentUsage(String pageID) {
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
			ResultSet rs = stmt.executeQuery("select DATE_FORMAT(created_time,'%y-%m') , count(*) from post_comments "
					+ "where page_id='" + pageID + "' group by DATE_FORMAT(created_time,'%y-%m') "
					+ "order by DATE_FORMAT(created_time,'%y-%m') desc limit 6; ");
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

			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rivalroosters?" + "user=root&password=root");
			Statement stmt = conn.createStatement();
			/*
			 * ResultSet rs = stmt.executeQuery(
			 * "SELECT Hour(created_time) AS hour, count(*) AS count " +
			 * "FROM   page_post WHERE  created_time BETWEEN '" + prevDate +
			 * "' and '" + currDate + "'" + "GROUP  BY hour ORDER  BY hour");
			 */
			ResultSet rs = stmt.executeQuery("SELECT case when ( Hour(created_time) <= 12) then "
					+ "CONCAT(Hour(created_time),' AM') when ( Hour(created_time) >12 ) "
					+ "then CONCAT(Hour(created_time)-12,' PM') else Hour(created_time) "
					+ "end  AS hour, count(*) AS count ,Hour(created_time) as hr FROM   post_comments "
					+ "WHERE  DATE_FORMAT(created_time,'%y-%m-%d')= date_format('2015-05-09','%y-%m-%d') "
					+ "and page_id ='" + pageID + "'group by hour order by Hour(created_time) asc ;");
			//int i=0;
			HashSet<String> set = new HashSet<String>();
			while (rs.next()) {
				/*if(rs.getString(3).equalsIgnoreCase(String.valueOf(i))){
				graphVO.getXticks().add(rs.getString(1));
				graphVO.getValues().add(rs.getInt(2));
				} else {
					if(i<=12 ) {
					graphVO.getXticks().add(i+ " AM");
					} else {
					graphVO.getXticks().add((i-12)+ " PM");	
					}
					graphVO.getValues().add(0);
				}*/
				graphVO.getXticks().add(rs.getString(1));
				graphVO.getValues().add(rs.getInt(2));
			
			}
			/*GraphVO newGraphVO = new GraphVO();
			for (int i =0 ;i <24 ;i++) {
				if(graphVO.)
			}*/
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
	public UserGraphVO topkUsers(String pageID, int k) {
		Connection conn = null;
		UserGraphVO graphVO = new UserGraphVO();
		try {
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rivalrooster?" + "user=root&password=root");
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select  user_name,like_count, comment_count from fb_user_activity "
					+ "where Page_id='" + pageID + "' and like_count!=0 and comment_count!=0 "
					+ "order by (like_count+comment_count) desc limit 5;");
			while (rs.next()) {
				graphVO.getXticks().add(rs.getString(1));
				graphVO.getValues1().add(rs.getInt(2));
				graphVO.getValues2().add(rs.getInt(3));
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
	public double getscore(String pageID) {
		double score = 0;
		double pagelike = scorepageLikes(pageID);
		double postlikecomments = scorepostlikescomments(pageID);
		score = (pagelike + postlikecomments)/ 2;
		return score * 100;
	}

	private double scorepageLikes(String pageID) {
		Connection conn = null;
		List<Double> scores = new ArrayList<Double>();

		try {
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rivalrooster?" + "user=root&password=root");
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select page_likes from page_facebook where page_id='" + pageID + "'"
					+ "union all select max(page_likes) from page_facebook;");
			while (rs.next()) {
				System.out.println(rs.getInt(1));
				scores.add((double) rs.getInt(1));
			}

		} catch (Exception ex) {

		} finally {

		}
		return scores.get(0) / scores.get(1);
	}

	private double scorepostlikescomments(String pageID) {

		Connection conn = null;
		List<Double> scores = new ArrayList<Double>();

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
					.executeQuery("select sum(like_count) + sum(comment_count) from fb_user_activity "
							+ "where page_id='"
							+ pageID
							+ "' union all select Max(temp.sumcount) from "
							+ "(select sum(like_count) + sum(comment_count) as sumcount from fb_user_activity group by page_id ) as temp");
			while (rs.next()) {
				scores.add((double) rs.getInt(1));
			}

		} catch (Exception ex) {

		} finally {

		}
		return scores.get(0) / scores.get(1);
	}

	/*
	 * 
	 * 
	 *
	 */

	public List<Integer> getSentiments(String pageID) {
		List<Integer> totalSentiments = new ArrayList<Integer>();
		//List<Integer> sentimentsPost = getSentimentsofPosts(pageID);
		List<Integer> sentimentComments = getSentimentsofComments(pageID);
		//totalSentiments.add(sentimentsPost.get(0) + sentimentsPost.get(1));
		totalSentiments.add(sentimentComments.get(0) + sentimentComments.get(1));
		return sentimentComments;
	}

	/*
	 * 
	 * 
	 * 
	 */
	private List<Integer> getSentimentsofPosts(String pageID) {
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
			ResultSet rs = stmt.executeQuery("select count(*) from page_post where Sentiment ='positive' "
					+ "and Page_id='" + pageID + "' Union select count(*) from page_post "
					+ "where Sentiment ='negative' and Page_id='" + pageID + "';");
			while (rs.next()) {
				sentList.add(rs.getInt(1));
			}

		} catch (Exception ex) {

		} finally {

		}
		return sentList;

	}

	private List<Integer> getSentimentsofComments(String pageID) {

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
			ResultSet rs = stmt.executeQuery("select count(*) from post_comments where "
					+ "Sentiment ='positive' and Page_id='" + pageID + "' Union select count(*) "
					+ "from post_comments where Sentiment ='negative' and Page_id='" + pageID + "';");
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
	public List<Tag> getTags() {
		Connection conn = null;
		List<Tag> tags = new ArrayList<Tag>();

		try {
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rivalrooster?" + "user=root&password=root");
			Statement stmt = conn.createStatement();
			// ResultSet rs = null;
			/*
			 * if (excludeID != null && excludeID != "" && excludeID.length() !=
			 * 0) { rs =
			 * stmt.executeQuery("select page_id , page_name from page_facebook "
			 * + "where page_id not in ('" + excludeID + "');"); } else { rs =
			 * stmt
			 * .executeQuery("select page_id , page_name from page_facebook"); }
			 */
			ResultSet rs = stmt.executeQuery("select page_id , page_name from page_facebook");
			while (rs.next()) {
				Tag tag = new Tag();
				tag.setPageID(rs.getString(1));
				tag.setPageName(rs.getString(2));
				tags.add(tag);

			}

		} catch (Exception ex) {

		} finally {

		}
		return tags;
	}
	
	/*
	 * 
	 * 
	 * 
	 */
	
	public GraphVO locationStats(String pageID) {
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
			ResultSet rs = stmt.executeQuery("select location, count(*) as count from fb_user_activity "
					+ "where Page_id='"+pageID+"' and location is not null "
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
}
