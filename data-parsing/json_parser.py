#!/usr/bin/env python

import json
import os, MySQLdb
import time


#==============================================================================
# Variables
#==============================================================================

# Some descriptive variables
#name                = "rivalroasters"
#version             = "0.1.0"
#long_description    = """rivalroasters is a platform to compare business growth in different social media"""
#url                 = "https://github.com/prashantprakash/BigDataProject"
#license             = "MIT"

#==============================================================================
pizzahut_pageid = "6053772414"
papajohn_pageid = "34703237638"
mcdonald_pageid = "50245567013"
subway_pageid = "224383614973"
dominos_pageid = "6657899956"

def parse_json():
    post_message = "Worst sub ever"
    page_id_val = dominos_pageid
    folder_path='''/Users/Dany/Documents/FALL-2013-COURSES/Imp_Data_structures/workspace/big-data/BigDataProject/dataset/facebook/food-beverages/dominos/'''
    for file_name in os.listdir(folder_path):
    	if file_name != ".DS_Store":
            with open(folder_path+file_name) as json_file:
                print file_name
                data = json.load(json_file)
                #print data
            for post in data["data"]:
                post_id = post['id']
                print "file name : "+file_name+" post Id : "+str(post_id) +'\n'
                if 'message' in post:
                    post_message = post['message'].encode('utf-8')
                if 'created_time' in post:
                    created_time = post['created_time']
                if 'shares' in post:
                    share = post['shares']
                    if 'count' in share:
                        share_count = share['count']
                print "Share Count "+str(share_count)
                print post_message
                
                like_ids = "["
                if 'likes' in post:
                    for like in post['likes']['data']:
                        if 'id' in like:
                            like_id = like['id']
                        if 'name' in like:
                            liked_by_name = like['name'].encode('utf-8')
                        like_ids = like_ids + "["+str(like_id)+"::"+str(liked_by_name)+"],"
                        print "Liked by "+liked_by_name + '\n'
                        #insert_user(like_id, liked_by_name,"", "")
                        insert_like_user_activity(like_id, liked_by_name, 1, 0, "", "", page_id_val)
                    like_ids = like_ids + "]"
                    #Insert post into table
                insert_post(post_id, post_message, parse_date(created_time), share_count, like_ids, page_id_val)

                if 'comments' in post:
                    comment_info = post['comments']
                    if comment_info:
                        for comment in comment_info['data']:
                            if 'id' in comment:
                                comment_id = comment['id']
                            if 'from' in comment:
                                comment_from = comment['from']
                                if 'id' in comment_from:
                                    commented_by_id = comment_from['id']
                                if 'name' in comment_from:
                                    commented_by_name = comment_from['name'].encode('utf-8')
                            if 'message' in comment:
                                comment_message = comment['message'].encode('utf-8')
                            if 'like_count' in comment:
                                likes_count = comment['like_count']
                            if 'created_time' in comment:
                                created_time = comment['created_time']
                            print "Commented by "+str(commented_by_name)
                            insert_comment_user_activity(commented_by_id, commented_by_name, 0, 1, "", "", page_id_val)
                            insert_comment(comment_id, post_id, comment_message, likes_count, parse_date(created_time), page_id_val)

def get_connection_object():
    db = MySQLdb.connect(host="localhost", # your host, usually localhost
                         user="root", # your username
                         passwd="", # your password
                         db="rivalrooster") # name of the data base
    return db


def insert_page(page_id, page_name, page_likes):
    conn = get_connection_object()
    
    # you must create a Cursor object. It will let
    #  you execute all the queries you need
    cur = conn.cursor()
    try:
        cur.execute("""INSERT INTO page_facebook VALUES (%s,%s,%s)""",(page_id, page_name, page_likes))
        conn.commit()
    except:
        conn.rollback()

    conn.close()

def insert_post(post_id, message, created_time, shares_count, like_ids, page_id):
    conn = get_connection_object()

    # you must create a Cursor object. It will let
    #  you execute all the queries you need
    cur = conn.cursor()
    try:
        cur.execute("""INSERT INTO page_post(post_id, message, created_time, shares_count, like_ids, page_id) VALUES (%s,%s,%s,%s,%s,%s)""",(post_id, message, created_time, int(shares_count), like_ids, page_id))
        conn.commit()
    except:
        conn.rollback()

    conn.close()

def insert_comment(comment_id, post_id, comment_message, likes_count, created_time, page_id):
    conn = get_connection_object()
    
    # you must create a Cursor object. It will let
    #  you execute all the queries you need
    cur = conn.cursor()
    try:
        cur.execute("""INSERT INTO post_comments(comment_id, post_id, comment_message, likes_count, created_time, page_id) VALUES (%s,%s,%s,%s,%s,%s)""",(comment_id, post_id, comment_message, likes_count, created_time, page_id))
        conn.commit()
    except:
        conn.rollback()
    
    conn.close()

def insert_user(user_id, user_name, lat, long):
    conn = get_connection_object()
    
    # you must create a Cursor object. It will let
    #  you execute all the queries you need
    cur = conn.cursor()
    try:
        cur.execute("""INSERT INTO user VALUES (%s,%s,%s,%s)""",(user_id, user_name, lat, long))
        conn.commit()
    except:
        conn.rollback()
    
    conn.close()

def insert_like_user_activity(user_id, user_name, like_count, comment_count, lat, long, page_id):
    conn = get_connection_object()
    
    # you must create a Cursor object. It will let
    #  you execute all the queries you need
    cur = conn.cursor()
    try:
        cur.execute("""INSERT INTO fb_user_activity (user_id, page_id, user_name, like_count, comment_count, latitude, longitude) VALUES (%s, %s, %s, %s, %s, %s, %s) ON DUPLICATE KEY UPDATE like_count=like_count+1""",(user_id, page_id, user_name, int(like_count), int(comment_count), lat, long))
        conn.commit()
    except:
        conn.rollback()

    conn.close()

def insert_comment_user_activity(user_id, user_name, like_count, comment_count, lat, long, page_id):
    conn = get_connection_object()
    # you must create a Cursor object. It will let
    #  you execute all the queries you need
    cur = conn.cursor()
    try:
        cur.execute("""INSERT INTO fb_user_activity (user_id, page_id, user_name, like_count, comment_count, latitude, longitude) VALUES (%s, %s, %s, %s, %s, %s, %s) ON DUPLICATE KEY UPDATE comment_count=comment_count+1""",(user_id, page_id, user_name, int(like_count), int(comment_count), lat, long))
        
        conn.commit()
    except:
        conn.rollback()
    
    conn.close()

def parse_date(date_val):
    timestamp = date_val
    ts = time.strptime(timestamp[:19], "%Y-%m-%dT%H:%M:%S")
    parsed_val = time.strftime("%Y-%m-%d %H:%M:%S", ts)
    print(parsed_val)
    return parsed_val


#INSERT INTO fb_user_activity (user_id, user_name, like_count, comment_count, latitude, longitude, page_id) VALUES ("769615923057747", "Dinesh Appavoo", 0, 1, "", "", "6657899956") ON DUPLICATE KEY UPDATE comment_count=comment_count+1;
#INSERT INTO fb_user_activity (user_id, user_name, like_count, comment_count, latitude, longitude) VALUES ("769615923057745", "Dinesh Appavoo", 1, 0, "", "") ON DUPLICATE KEY UPDATE like_count=like_count+1;

#INSERT INTO page_post(post_id, message, created_time, shares_count, like_ids, page_id) VALUES ("123", "ifjerifg edjhgdfjg ighdgid", "07/29/2014", 4, "[[34324::feere]]", "224383614973");

if __name__ == "__main__":
   # stuff only to run when not called via 'import' here
    #insert_page("6053772414", "Pizza Hut", 25392986)
    #insert_page("34703237638", "Papa John's Pizza", 2828328)
    #insert_page("224383614973", "Subway", 25963895)
    #insert_page("6657899956", "Domino's Pizza", 10019321)
    #insert_page("50245567013", "McDonald's", 56812153)

    #insert_like_user_activity("769615923057745", "Dinesh Appavoo", 1, 0, "", "")
    #insert_comment_user_activity("769615923057745", "Dinesh Appavoo", 0, 1, "", "")

    #parse_date("2014-07-29T15:26:17+0000")

    #insert_post("123", "ifjerifg edjhgdfjg ighdgid", parse_date("2014-07-29T15:26:17+0000"), 4, "[[34324::feere]]", "224383614973")
    #insert_comment("456", "123", "Worst sub", 2, parse_date("2014-07-29T15:26:17+0000"), "224383614973")

    parse_json()

