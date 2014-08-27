class TwitterFilter

  def initialize
    @extractor = TweetExtractor.new
    @tweet_arr = []
    @retweet_arr = []
    @mentions_arr = []
  end

  def filter_tweets(friend)
    clean_screenname = friend[1..-1]
    @base_arr = Tweet.where("tweet_text LIKE ?", "%#{clean_screenname}%")
    @tweet_arr = @base_arr.select { |tweet| tweet["retweeted"] != true && tweet[:mention] != true }
    @extractor.extract_ids(@tweet_arr)
  end

  def filter_retweets(friend)
    clean_screenname = friend[1..-1]
    @base_arr = Tweet.where("retweeted_status LIKE ?", "%#{clean_screenname}%")
    @retweet_arr = @base_arr.select { |tweet| tweet["retweeted"] == true }
    @extractor.extract_ids(@retweet_arr)
  end

  def filter_mentions(username, friend)
    clean_screenname = friend[1..-1]
    @base_arr = Tweet.where("tweet_text LIKE ?", "%#{username}%")
    @mentions_arr = @base_arr.select { |tweet| tweet[:mention] == true && tweet["user_who_posted"]["screen_name"] == clean_screenname }
    @extractor.extract_ids(@mentions_arr)
  end

end