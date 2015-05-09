#!/usr/bin/env python

import json
import os, MySQLdb


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
def parse_json():
    pizzahut_pageid = "6053772414"
    papajohn_pageid = "34703237638"
    folder_path='''/Users/Dany/Documents/FALL-2013-COURSES/Imp_Data_structures/workspace/big-data/BigDataProject/dataset/facebook/food-beverages/pizzahut/'''
    for file_name in os.listdir(folder_path):
    	if file_name != ".DS_Store":
            with open(folder_path+file_name) as json_file:
                print file_name
                data = json.load(json_file)
                #print data
            for post in data["data"]:
                post_id = post['id']
                print "file name : "+file_name+" post Id : "+str(post_id) +'\n'
                post_message = post['message'].encode('utf-8')
                created_time = post['created_time']
                share_count = post['shares']['count']
                print "Share Count "+str(share_count)
                print post_message
                
                like_ids = "["
                for like in post['likes']['data']:
                   like_id = like['id']
                   liked_by_name = like['name'].encode('utf-8')
                   like_ids = like_ids + "["+str(like_id)+"::"+str(liked_by_name)+"],"
                   print "Liked by "+liked_by_name + '\n'
                like_ids = like_ids + "]"
                #Insert post into table
                #insert_post(post_id, post_message, created_time, share_count, like_ids, pizzahut_pageid)


                for comment in post['comments']['data']:
                    comment_id = comment['id']
                    commented_by_id = comment['from']['id']
                    commented_by_name = comment['from']['name'].encode('utf-8')
                    comment_message = comment['message'].encode('utf-8')
                    likes_count = comment['like_count']
                    created_time = comment['created_time']
                    print "Commented by "+str(commented_by_name)
#insert_comment(comment_id, post_id, comment_message, likes_count, created_time, pizzahut_pageid)

def get_connection_object():
    db = MySQLdb.connect(host="localhost", # your host, usually localhost
                         user="root", # your username
                         passwd="", # your password
                         db="rivalroasters") # name of the data base
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
        cur.execute("""INSERT INTO page_post VALUES (%s,%s,%s,%s,%s,%s)""",(post_id, message, created_time, shares_count, like_ids, page_id))
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
        cur.execute("""INSERT INTO page_comment VALUES (%s,%s,%s,%s,%s,%s)""",(comment_id, post_id, comment_message, likes_count, created_time, page_id))
        conn.commit()
    except:
        conn.rollback()
    
    conn.close()


if __name__ == "__main__":
   # stuff only to run when not called via 'import' here
   #call email service
    #insert_page("6053772414", "Pizza Hut", 25392986)
    #insert_page("34703237638", "Papa John's Pizza", 2828328)
    parse_json()
