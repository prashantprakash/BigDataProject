import twitter4j.*;
import twitter4j.auth.AccessToken;

import java.io.PrintWriter;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by bhumikasaivamani on 5/7/15.
 */
public class TwitterTest
{
    int count;
    public Set<Long> TweetIds;
    public TwitterTest()
    {
        count=0;
        TweetIds=new HashSet<Long>();
    }
    public void ExtractData(List<Status> statuses)
    {
        try {
            for (Status status : statuses) {
                if (status.isRetweet())
                    continue;
                if (status.getText().startsWith("@"))
                    continue;
                System.out.println("@" + status.getId() + "-" + status.getText() + "-" + status.getCreatedAt() + "-" + status.getFavoriteCount() + "-" + status.getRetweetCount());

                TweetIds.add(status.getId());
                count++;
            }

        } catch (Exception te) {
            te.printStackTrace();
            System.out.println("Failed to search tweets: " + te.getMessage());
            System.exit(-1);

        }

    }
    public static void main(String[] args) throws Exception
    {
        TwitterTest tw=new TwitterTest();
        Twitter twitter = new TwitterFactory().getInstance();
        //twitter.setOAuthConsumer();

        twitter.setOAuthConsumer("wd3TpLxZ32r049EA6f2j2QSQx", "wLlAeB1k8uqC0sUXJV4TPmky8NFok3PlSkRnjV4xpumqqvi8yE");
        AccessToken accessToken = new AccessToken("3187272186-5uauq5X11DOwDYN3AnWCFKoUI4efOnEvRpitizF", "XJWcLGKORK4fiqNg9r8bOoIe7e28sUr1g9go9oFQ3UfkU");
        /*twitter.setOAuthConsumer("FCpOrs29C95hX1y4IRUqIpXrt", "O5IFQ6CDK2ePg1oB4n3rM1D3r3dhR5yTsjxp3j0QCNKjnPG3Xa");
        AccessToken accessToken = new AccessToken("3187272186-zHwHiz95CI3YskmBcGlKx79XI3Zp8ERlUtyxAEW", "Y4n2lLDHFVyb3I5U3vAyIcU4tUN9xvf1CVTRjfNlwec9W");*/

        twitter.setOAuthAccessToken(accessToken);
        PrintWriter writer = new PrintWriter("/Users/bhumikasaivamani/TwitterData/TwitterDataDennys.txt", "UTF-8");
        //writer.println("The first line");
        int page=1;
        int tweetCount=10000;
        try {
           do {
                List<Status> statuses;
               //long temp=582570992196853760L;
                Paging paging = new Paging(page, tweetCount);
                statuses = twitter.getUserTimeline("dennysdiner", paging);
                // tw.ExtractData(statuses);
                for (Status status : statuses) {
                    if (status.isRetweet())
                        continue;
                    if (status.getText().startsWith("@"))
                        continue;
                    //System.out.println(status.getCurrentUserRetweetId());
                    System.out.println("@" + status.getId() + "-" + status.getText() + "-" + status.getCreatedAt() + "-" + status.getFavoriteCount() + "-" + status.getRetweetCount());
                    tw.TweetIds.add(status.getId());
                    String statusText=status.getText().replace("\n","");
                    writer.append(status.getId()+":::"+statusText+":::"+status.getCreatedAt()+":::"+status.getRetweetCount()+":::"+status.getFavoriteCount() +":::@dennysdiner");
                    writer.append("\n");
                    //System.out.println("\n");
                    tw.count++;
                }
                page = page + 1;

            } while (page < 30) ;
        }
        catch (Exception e) {
        System.out.println("e:" + e.getMessage());
    }
    writer.close();
        System.out.println(tw.count);

    }
}
