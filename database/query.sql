CREATE TABLE page
(
page_id VARCHAR(100),
page_name VARCHAR(250),
page_likes INTEGER,
PRIMARY KEY (page_id)
);

CREATE TABLE page_post
(
post_id VARCHAR(100),
message VARCHAR(1000),
created_time DATE,
shares_count INTEGER,
like_ids VARCHAR(5000),
page_id VARCHAR(100),
PRIMARY KEY (post_id)
);

CREATE TABLE page_twitter
(
page_id VARCHAR(100),
page_name VARCHAR(250),
page_followers INTEGER,
PRIMARY KEY (page_id)
);

CREATE TABLE page_tweets
(
tweet_id VARCHAR(100),
tweet_text VARCHAR(250),
created_time DATE,
retweet_count INTEGER,
favourites_ids VARCHAR(5000),
page_id VARCHAR(100),
PRIMARY KEY (tweet_id)
);

CREATE TABLE post_comments
(
comment_id VARCHAR(100),
post_id VARCHAR(100),
comment_message VARCHAR(5000),
likes_count INTEGER,
created_time DATE,
page_id VARCHAR(100),
PRIMARY KEY (comment_id)
);

ALTER TABLE page_post ADD FOREIGN KEY (page_id) REFERENCES page (page_id);

ALTER TABLE page_tweets ADD FOREIGN KEY (page_id) REFERENCES page_twitter (page_id);

ALTER TABLE post_comments ADD FOREIGN KEY (post_id) REFERENCES page_post (post_id);

ALTER TABLE post_comments ADD FOREIGN KEY (page_id) REFERENCES page (page_id);