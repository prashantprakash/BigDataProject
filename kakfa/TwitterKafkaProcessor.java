/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.apache.spark.examples.streaming;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Arrays;
import java.util.regex.Pattern;

import scala.Tuple2;

import com.google.common.collect.Lists;

import kafka.serializer.StringDecoder;

import org.apache.spark.SparkConf;
import org.apache.spark.api.java.function.*;
import org.apache.spark.streaming.api.java.*;
import org.apache.spark.streaming.kafka.KafkaUtils;
import org.apache.spark.streaming.Durations;

/**
 * Consumes messages from one or more topics in Kafka and does wordcount.
 * Usage: DirectKafkaWordCount <brokers> <topics>
 *   <brokers> is a list of one or more Kafka brokers
 *   <topics> is a list of one or more kafka topics to consume from
 *
 * Example:
 *    $ bin/run-example streaming.KafkaWordCount broker1-host:port,broker2-host:port topic1,topic2
 */

public final class JavaDirectKafkaWordCount {
  private static final Pattern SPACE = Pattern.compile(" ");

  class Page{
	  String pageId;
	  ArrayList<String> followers;
	/**
	 * @return the pageId
	 */
	public String getPageId() {
		return pageId;
	}
	/**
	 * @param pageId the pageId to set
	 */
	public void setPageId(String pageId) {
		this.pageId = pageId;
	}
	/**
	 * @return the followers
	 */
	public ArrayList<String> getFollowers() {
		return followers;
	}
	/**
	 * @param followers the followers to set
	 */
	public void setFollowers(ArrayList<String> followers) {
		this.followers = followers;
	}
  }
  class Tweet{
	  String tweetId;
	  String tweetMessage;
	  int noOfRetweets;
	  String replyId;
	/**
	 * @return the tweetId
	 */
	public String getTweetId() {
		return tweetId;
	}
	/**
	 * @param tweetId the tweetId to set
	 */
	public void setTweetId(String tweetId) {
		this.tweetId = tweetId;
	}
	/**
	 * @return the tweetMessage
	 */
	public String getTweetMessage() {
		return tweetMessage;
	}
	/**
	 * @param tweetMessage the tweetMessage to set
	 */
	public void setTweetMessage(String tweetMessage) {
		this.tweetMessage = tweetMessage;
	}
	/**
	 * @return the noOfRetweets
	 */
	public int getNoOfRetweets() {
		return noOfRetweets;
	}
	/**
	 * @param noOfRetweets the noOfRetweets to set
	 */
	public void setNoOfRetweets(int noOfRetweets) {
		this.noOfRetweets = noOfRetweets;
	}
	/**
	 * @return the replyId
	 */
	public String getReplyId() {
		return replyId;
	}
	/**
	 * @param replyId the replyId to set
	 */
	public void setReplyId(String replyId) {
		this.replyId = replyId;
	}
  }
  
  class ReTweet{
	  String reTweetId;
	  String message;
	/**
	 * @return the reTweetId
	 */
	public String getReTweetId() {
		return reTweetId;
	}
	/**
	 * @param reTweetId the reTweetId to set
	 */
	public void setReTweetId(String reTweetId) {
		this.reTweetId = reTweetId;
	}
	/**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}
	/**
	 * @param message the message to set
	 */
	public void setMessage(String message) {
		this.message = message;
	}
	  
  }
  public static void main(String[] args) {
    if (args.length < 2) {
      System.err.println("Usage: DirectKafkaWordCount <brokers> <topics>\n" +
          "  <brokers> is a list of one or more Kafka brokers\n" +
          "  <topics> is a list of one or more kafka topics to consume from\n\n");
      System.exit(1);
    }

    StreamingExamples.setStreamingLogLevels();

    String brokers = args[0];
    String topics = args[1];

    // Create context with 2 second batch interval
    SparkConf sparkConf = new SparkConf().setAppName("JavaDirectKafkaWordCount");
    JavaStreamingContext jssc = new JavaStreamingContext(sparkConf, Durations.seconds(2));

    HashSet<String> topicsSet = new HashSet<String>(Arrays.asList(topics.split(",")));
    HashMap<String, String> kafkaParams = new HashMap<String, String>();
    kafkaParams.put("metadata.broker.list", brokers);

    // Create direct kafka stream with brokers and topics
    JavaPairInputDStream<String, String> messages = KafkaUtils.createDirectStream(
        jssc,
        String.class,
        String.class,
        StringDecoder.class,
        StringDecoder.class,
        kafkaParams,
        topicsSet
    );

    // Get the lines, split them into words, count the words and print
    JavaDStream<String> lines = messages.map(new Function<Tuple2<String, String>, String>() {
      @Override
      public String call(Tuple2<String, String> tuple2) {
        return tuple2._2();
      }
    });
    JavaDStream<String> words = lines.flatMap(new FlatMapFunction<String, String>() {
      @Override
      public Iterable<String> call(String x) {
        return Lists.newArrayList(SPACE.split(x));
      }
    });
    JavaPairDStream<String, Integer> wordCounts = words.mapToPair(
      new PairFunction<String, String, Integer>() {
        @Override
        public Tuple2<String, Integer> call(String s) {
          return new Tuple2<String, Integer>(s, 1);
        }
      }).reduceByKey(
        new Function2<Integer, Integer, Integer>() {
        @Override
        public Integer call(Integer i1, Integer i2) {
          return i1 + i2;
        }
      });
    wordCounts.print();

    // Start the computation
    jssc.start();
    jssc.awaitTermination();
  }
}
