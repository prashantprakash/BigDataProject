package com.src.rivalrooster;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;

/**
 * Servlet implementation class TweetOperation
 */
@WebServlet("/toperation")
public class TweetOperation extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TweetOperation() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String choice = request.getParameter("choice");
		TweetDAO tweetDAO = new TweetDAO();
		if ("monthusage".equalsIgnoreCase(choice)) {
			String pageName = request.getParameter("pagename");
			UserGraphVO graphVO = tweetDAO.last6MonthsUsage(pageName);
			ObjectMapper mapper = new ObjectMapper();
			response.getWriter().println(mapper.writeValueAsString(graphVO));

		} else if ("tags".equalsIgnoreCase(choice)) {
			List<String> tags = tweetDAO.getTags();
			ObjectMapper mapper = new ObjectMapper();
			response.getWriter().println(mapper.writeValueAsString(tags));

		} else if ("hoursusage".equalsIgnoreCase(choice)) {
			String pageName = request.getParameter("pagename");
			Date currdate = null;
			GraphVO graphVO = tweetDAO.hours24Usage(pageName, currdate);
			ObjectMapper mapper = new ObjectMapper();
			response.getWriter().println(mapper.writeValueAsString(graphVO));

		} else if ("location".equalsIgnoreCase(choice)) {
			String pageID = request.getParameter("pagename");
			GraphVO graphVO = tweetDAO.locationStats(pageID);
			ObjectMapper mapper = new ObjectMapper();
			response.getWriter().println(mapper.writeValueAsString(graphVO));
		} else if ("sentiments".equalsIgnoreCase(choice)) {
			String pageName = request.getParameter("pagename");
			List<Integer> sentiments = tweetDAO.getSentiments(pageName);
			ObjectMapper mapper = new ObjectMapper();
			response.getWriter().println(mapper.writeValueAsString(sentiments));
		}
		
		else if ("score".equalsIgnoreCase(choice)) {
			String pageName = request.getParameter("pagename");
			double score = tweetDAO.getscore(pageName);
			ObjectMapper mapper = new ObjectMapper();
			response.getWriter().println(mapper.writeValueAsString(score));
		}else if ("topkusers".equalsIgnoreCase(choice)) {
			String pageName = request.getParameter("pagename");
			GraphVO userGraphVO = tweetDAO.topkUsers(pageName, 5);
			ObjectMapper mapper = new ObjectMapper();
			response.getWriter().println(mapper.writeValueAsString(userGraphVO));
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
			IOException {
		// TODO Auto-generated method stub
	}

}
