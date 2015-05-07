package com.src.twitter;

import java.util.List;

import twitter4j.Query;
import twitter4j.QueryResult;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.auth.AccessToken;

public class SearchTweets {
	
	public static void main(String [] args) {
		Twitter twitter = new TwitterFactory().getInstance();
		//twitter.setOAuthAccessToken(AOwxBOAO12wiF7YNkNDWkIdFJpk7HdQE);
		twitter.setOAuthConsumer("ZOd9O4k4MkrfOmNQs3dUttDwZ", "Kz9X6T1FhlxP6896Gp5VAZbUmliiJjBNVvSVvQrc1Ju6VPFbee");
		AccessToken accessToken  = new  AccessToken("111073755-QqoVU3OKzEI8YylvFFN6DsVlgf0HXxhqIEAP3Xk3", "iH6FYVb9JQMz2640ABswhhCs51orfK7U3eYpmPnuG8dYG");
		twitter.setOAuthAccessToken(accessToken);
		try {
            Query query = new Query("FinancialTimes");
            QueryResult result;
            do {
                result = twitter.search(query);
                List<Status> tweets = result.getTweets();
                for (Status tweet : tweets) {
                    System.out.println("@" + tweet.getUser().getScreenName() + " - " + tweet.getText()+"-"+ tweet.getRetweetCount());
                }
            } while ((query = result.nextQuery()) != null);
            System.exit(0);
        } catch (TwitterException te) {
            te.printStackTrace();
            System.out.println("Failed to search tweets: " + te.getMessage());
            System.exit(-1);
        } 
		
		
		/*try{
		 	Twitter twitter = TwitterFactory.getSingleton();
		    twitter.setOAuthConsumer("ZOd9O4k4MkrfOmNQs3dUttDwZ", "Kz9X6T1FhlxP6896Gp5VAZbUmliiJjBNVvSVvQrc1Ju6VPFbee");
		    RequestToken requestToken = twitter.getOAuthRequestToken();
		    AccessToken accessToken = null;
		    BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		    while (null == accessToken) {
		      System.out.println("Open the following URL and grant access to your account:");
		      System.out.println(requestToken.getAuthorizationURL());
		      System.out.print("Enter the PIN(if aviailable) or just hit enter.[PIN]:");
		      String pin = br.readLine();
		      try{
		         if(pin.length() > 0){
		           accessToken = twitter.getOAuthAccessToken(requestToken, pin);
		         }else{
		           accessToken = twitter.getOAuthAccessToken();
		         }
		         accessToken = twitter.getOAuthAccessToken();
		      } catch (TwitterException te) {
		        if(401 == te.getStatusCode()){
		          System.out.println("Unable to get the access token.");
		        }else{
		          te.printStackTrace();
		        }
		      }
		    }
		    //persist to the accessToken for future reference.
		    //storeAccessToken(twitter.verifyCredentials().getId() , accessToken);
		    //Status status = twitter.updateStatus(args[0]);
		    //System.out.println("Successfully updated the status to [" + status.getText() + "].");
		    System.exit(0);
		}catch(Exception ex) {
			System.err.println("Error in Fetching token");
		}*/
	}

}
