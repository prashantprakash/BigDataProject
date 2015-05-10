CREATE TABLE page_facebook
(
page_id VARCHAR(255),
page_name VARCHAR(2083),
page_likes INTEGER,
PRIMARY KEY (page_id)
);

CREATE TABLE page_post
(
post_id VARCHAR(255),
message VARCHAR(2083),
created_time DATE,
shares_count INTEGER,
like_ids VARCHAR(2083),
page_id VARCHAR(255),
sentiment VARCHAR(255),
PRIMARY KEY (post_id)
);

CREATE TABLE page_twitter
(
page_id VARCHAR(255),
page_name VARCHAR(2083),
page_followers INTEGER,
PRIMARY KEY (page_id)
);

CREATE TABLE fb_user_activity
(
user_id VARCHAR(255),
page_id VARCHAR(255),
user_name VARCHAR(2083),
like_count INTEGER,
comment_count INTEGER,
latitude VARCHAR(255),
longitude VARCHAR(255),
PRIMARY KEY (user_id, page_id)
);

CREATE TABLE page_tweets
(
tweet_id VARCHAR(255),
tweet_text VARCHAR(2083),
created_time DATE,
retweet_count INTEGER,
favourites_ids VARCHAR(2083),
page_id VARCHAR(255),
PRIMARY KEY (post_id)
);

CREATE TABLE post_comments
(
comment_id VARCHAR(255),
post_id VARCHAR(255),
comment_message VARCHAR(2083),
likes_count INTEGER,
created_time DATE,
page_id VARCHAR(255),
sentiment VARCHAR(255),
PRIMARY KEY (comment_id)
);

CREATE TABLE user
(
user_id VARCHAR(255),
user_name VARCHAR(255),
lat VARCHAR(255),
lang VARCHAR(255)
);

ALTER TABLE page_post ADD FOREIGN KEY (page_id) REFERENCES page_facebook (page_id);

ALTER TABLE page_tweets ADD FOREIGN KEY (page_id) REFERENCES page_twitter (page_id);

ALTER TABLE post_comments ADD FOREIGN KEY (post_id) REFERENCES page_post (post_id);

ALTER TABLE post_comments ADD FOREIGN KEY (page_id) REFERENCES page_facebook (page_id);

ALTER TABLE fb_user_activity ADD FOREIGN KEY (page_id) REFERENCES page_facebook (page_id);

