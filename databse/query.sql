/* SQLEditor (Generic SQL)*/

CREATE TABLE page
(
page_id VARCHAR,
page_name VARCHAR,
page_likes INTEGER,
PRIMARY KEY (page_id)
);

CREATE TABLE page_post
(
post_id VARCHAR,
message VARCHAR,
created_time DATE,
shares_count INTEGER,
like_ids VARCHAR,
page_id VARCHAR,
PRIMARY KEY (post_id)
);

CREATE TABLE page_twitter
(
page_id VARCHAR,
page_name VARCHAR,
page_followers INTEGER,
PRIMARY KEY (page_id)
);

CREATE TABLE page_tweets
(
tweet_id VARCHAR,
tweet_text VARCHAR,
created_time DATE,
retweet_count INTEGER,
favourites_ids VARCHAR,
page_id VARCHAR,
PRIMARY KEY (post_id)
);

CREATE TABLE post_comments
(
comment_id VARCHAR,
post_id VARCHAR,
comment_message VARCHAR,
likes_count INTEGER,
created_time DATE,
page_id VARCHAR,
PRIMARY KEY (comment_id)
);

ALTER TABLE page_post ADD FOREIGN KEY (page_id) REFERENCES page (page_id);

ALTER TABLE page_tweets ADD FOREIGN KEY (page_id) REFERENCES page_twitter (page_id);

ALTER TABLE post_comments ADD FOREIGN KEY (post_id) REFERENCES page_post (post_id);

ALTER TABLE post_comments ADD FOREIGN KEY (page_id) REFERENCES page (page_id);
