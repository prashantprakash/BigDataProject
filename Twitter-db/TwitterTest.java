import twitter4j.*;
import twitter4j.auth.AccessToken;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.PrintWriter;
import java.util.*;


public class TwitterTest
{
    int count;
    public List<Long> followerIds =  new ArrayList<Long>();
    public List<Long> TweetIds = new ArrayList<Long>();
    public Map<Long,Integer> reTweetCounts = new HashMap<Long, Integer>();
    public TwitterTest()
    {
        count=0;
    }

    public void getRetweet(Twitter twitter) throws Exception {

        PrintWriter writer1 = new PrintWriter("/Users/ashwini/TwitterData/TwitterDataSubwayDominosDetails1.txt", "UTF-8");
        //PrintWriter writer3 = new PrintWriter("/Users/ashwini/TwitterData/TwitterDataMCDonaldsRetweetsCount.txt", "UTF-8");

        String fileName = "/Users/ashwini/TwitterData/TwitterDataDominosTweets.txt";

        try {
            BufferedReader br = new BufferedReader(new FileReader(fileName));
            String line;
            while ((line = br.readLine()) != null) {
                TweetIds.add(Long.parseLong(line.split(":::")[0],10));
            }
            br.close();
        } catch (Exception e) {

        }

          /* get retweet ids */
        String s ="";
        int k= 0;
        int tt =0;
       System.out.println("size:" + TweetIds.size());
           // for (int i = 0; i < 3; i++) {
              int i=0;
                do {
                Long l = TweetIds.get(i);
                IDs ids = twitter.getRetweeterIds(l, 100);
                int c = 1;
                k++;
                for (long n : ids.getIDs()) {
                    s = s + l + ":::" + n + ":::";
                    User user = twitter.showUser(n);
                    s = s + user.getScreenName() + ":::" + user.getLocation() + "\n";
                    System.out.println("count=" + k + "..." + c++ + "tt=" + tt);
                    //s = s + "\n";
                    if(tt<15){
                       break;
                    }
                }
                    i++;
                // writer1.append(s);
                }while (tt < 15);
           // }

        writer1.append(s);

        writer1.close();
    }
    public void getTweets(Twitter twitter) throws Exception {

             /*Page details*/
        //McDonalds - 71026122
        //Dominos : 31444922
        //Subway : 20632796


        PrintWriter writer = new PrintWriter("/Users/ashwini/TwitterData/TwitterDataSubwayTweets1.txt", "UTF-8");

        int page=1;
        int tweetCount=10000;
        do {
        List<Status> statuses;
        //long temp=582570992196853760L;
        Paging paging = new Paging(page, tweetCount);
        statuses = twitter.getUserTimeline("subway", paging);
        for (Status status : statuses) {
            if (status.isRetweet())
                continue;
            if (status.getText().startsWith("@"))
                continue;
            // System.out.println("@" + status.getId() + "-" + status.getText() + "-" + status.getCreatedAt() + "-" + status.getFavoriteCount() + "-" + status.getRetweetCount());
            TweetIds.add(status.getId());
            String statusText=status.getText().replace("\n","");
            writer.append(status.getId()+":::"+statusText+":::"+status.getCreatedAt()+":::"+status.getRetweetCount()+":::"+status.getFavoriteCount() +":::@subway");
            writer.append("\n");
            //System.out.println("\n");
            count++;
        }
        page = page + 1;

    } while (page < 30) ;

    writer.close();

}

    public void getFollowersDetails(Twitter twitter) throws Exception {

            /*Page details*/
        //McDonalds - 71026122
        //Dominos : 31444922
        //Subway : 20632796


        Long pageID1 = 71026122L;
        Long pageID2 = 31444922L;
        Long pageID3 = 20632796L;

        int c= 0;
        String fileName = "/Users/ashwini/TwitterData/TwitterDataSubwayFollowersIds.txt";
        PrintWriter writer2 = new PrintWriter("/Users/ashwini/TwitterData/TwitterDataSubwayFollowersDetails.txt", "UTF-8");
        try {
            BufferedReader br = new BufferedReader(new FileReader(fileName));
            String line;
            while ((line = br.readLine()) != null) {
                followerIds.add(Long.parseLong(line,10));
            }
            br.close();
        } catch (Exception e) {

        }

        String s= "";
      for(int i = 0 ;i< 170;i++){
            Long n = followerIds.get(i);
            User user = twitter.showUser(n);
            s = s + pageID3 + ":::" + n + ":::" + user.getScreenName()+ ":::" + user.getLocation()+"\n";
            System.out.println(c);
            c++;
        }

        writer2.append(s);
        writer2.close();

    }

    public void getFollowersIds(Twitter twitter) throws Exception {

          /*Page details*/
        //McDonalds - 71026122
        //Dominos : 31444922
        //Subway : 20632796

        PrintWriter writer2 = new PrintWriter("/Users/ashwini/TwitterData/TwitterDataSubwayFollowersIds.txt", "UTF-8");
        Long pageID1 = 71026122L;
        Long pageID2 = 31444922L;
        Long pageID3 = 20632796L;

        int c= 0;
        long cursor  =-1;
        String s ="";
        IDs fids;
        do {
            fids = twitter.getFollowersIDs(pageID3, cursor);

            for (long n : fids.getIDs()) {

                s = s + n + "\n";
              System.out.println("count=" + c++);
            }
            cursor = fids.getNextCursor();
        }while (c < 74999);

        writer2.append(s);
        writer2.close();
    }
    public void getPageDetails(Twitter twitter) throws Exception {

        /*Page details*/
        //McDonalds - 71026122
        //Dominos : 31444922
        //Subway : 20632796

        PrintWriter writer2 = new PrintWriter("/Users/ashwini/TwitterData/TwitterDataPages.txt", "UTF-8");
        Long pageID1 = 71026122L;
        Long pageID2 = 31444922L;
        Long pageID3 = 20632796L;


        User user = twitter.showUser(pageID1);
        String s = pageID1 +":::" +user.getDescription() + ":::" + user.getLocation() + ":::" + user.getFollowersCount()+"\n";
        user = twitter.showUser(pageID2);
        s = s + pageID2 +":::" +user.getDescription() + ":::" + user.getLocation() + ":::" + user.getFollowersCount()+"\n";
        user = twitter.showUser(pageID3);
        s = s + pageID3 +":::" +user.getDescription() + ":::" + user.getLocation() + ":::" + user.getFollowersCount();
        writer2.append(s);
        writer2.close();

    }


    public static void main(String[] args) throws Exception
    {
        TwitterTest tw=new TwitterTest();
        Twitter twitter = new TwitterFactory().getInstance();

       /* twitter.setOAuthConsumer("qBgmIKbgo67PnnaGUA50bbPbX", "8lw715WMCzBXxkPHRxvxijTDOsBsLkoEW43F3DwCtH85jquzb6");
        AccessToken accessToken = new AccessToken("1521469856-GkFioO789h0uAz1pHQpQTXUoO5bsikQMPY0GMlF", "sPmMr0Nf1anHTC8popUjXflD25b6OH1lfqA0RIvBSm8NX");*/

      /*  twitter.setOAuthConsumer("5FpEQoe3INGgMofELQH0sZTkb", "hrTltw1e9T7q0XISIfooEjmB5P7t7pD2YVWwNaDHhJfdiirOtR");
        AccessToken accessToken = new AccessToken("1521469856-URjgUe5l0H7ix7RSnl6yicovAOw3yVKm0rq9RZb", "kNBl06sUdJLQ1WslYRZtb8IY0m0UiASb6GVOD35EzzSMV");*/

       /* twitter.setOAuthConsumer("94np75P3hbcu5aDyjrhOUg9yq","Q4gwa3zrWK0P5TD2C5LFESSfb5mOrEacqJEZiunjEIj7ihpbN0");
        AccessToken accessToken = new AccessToken("1521469856-43ATwaWO5IRMKGwdctoDxyR1UCtYNffReFpe1tT","BEFrzqUJIbLEn5GPEYROcnBTKNzJfQy7LAMeRB8bNUH8Y");*/

        twitter.setOAuthConsumer("MnexJo6uulYgEOoeDTwDZkRzy","kwsTkWZ0Yew7WvCLRhh02HFYHrTLLIsUVPJQZJlKEThTaBDlaU");
        AccessToken accessToken = new AccessToken("3169266032-b1ShNvzfjVsv0slrwI7ehvdQbdRkmnQfMKu6UxY","cijzxEMpOjHi98onNaDkJSSDcJmrjaML9SGGhGvfajEGP");

      /* twitter.setOAuthConsumer("FCpOrs29C95hX1y4IRUqIpXrt", "O5IFQ6CDK2ePg1oB4n3rM1D3r3dhR5yTsjxp3j0QCNKjnPG3Xa");
        AccessToken accessToken = new AccessToken("3187272186-zHwHiz95CI3YskmBcGlKx79XI3Zp8ERlUtyxAEW", "Y4n2lLDHFVyb3I5U3vAyIcU4tUN9xvf1CVTRjfNlwec9W");*/

      /*  twitter.setOAuthConsumer("FYegiYQFK52Vy09RIusBXJRid","Ke7tbTlTQhu51ZEwJCV4uHbxBnVQvogOnxPhBLXi3p0MGbgDsN");
        AccessToken accessToken = new AccessToken("1521469856-3jqNfnIrpIwtdro84X1rVtTics8COB8rTrvdpv0","0jDYJp4F6YSX6WWSgFLKxwyq5EnWhf8edFSk7CSHRCmDS");*/

     /*   twitter.setOAuthConsumer("QD6P9f5jJYY2jJndKglG0EtCX","LXKnVamQVTqwQCeXmRf7qDFrF4yyBo7wPtHI6mUsxD6ubBKn7u");
        AccessToken accessToken = new AccessToken("3169266032-wnZshdDJvTssDiSJvrJBKs6JZgHpbN1sO1R9d46","m3pk1uujeW4I37CF8S6siRwXuGsKEN94UwJodU57fQUQT");*/


        twitter.setOAuthAccessToken(accessToken);


       try {

           //tw.getTweets(twitter);
          // tw.getPageDetails(twitter);
          // tw.getFollowersIds(twitter);
          // tw.getFollowersDetails(twitter);
           tw.getRetweet(twitter);


        }
        catch (Exception e) {
            System.out.println("e:" + e.getMessage());
        }

    }
}
