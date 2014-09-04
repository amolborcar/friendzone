class TwitterFilter

  def initialize
    @extractor = TweetExtractor.new
    @tweets_arr = []
    @retweets_arr = []
    @mentions_arr = []
    @screen_name
  end

  def find_screen_name_by_name(name)
    if Friend.where("name like ?", name).length != 0
      @screen_name = Friend.where("name like ?", name)[0]["screen_name"]
    else
      @screen_name = Follower.where("name like ?", name)[0]["screen_name"]
    end
  end

  def filter_tweets_by_name
    base_arr = Tweet.where("tweet_text LIKE ?", "%#{@screen_name}%")
    @tweets_arr = base_arr.select { |tweet| tweet["retweeted"] != true && tweet[:mention] != true }
    @extractor.extract_ids(@tweets_arr)
  end

  def filter_retweets_by_name
    base_arr = Tweet.where("retweeted_status LIKE ?", "%#{@screen_name}%")
    @retweets_arr = base_arr.select { |tweet| tweet["retweeted"] == true }
    @extractor.extract_ids(@retweets_arr)
  end

  def filter_mentions_by_name(username)
    base_arr = Tweet.where("tweet_text LIKE ?", "%#{username}%")
    @mentions_arr = base_arr.select { |tweet| tweet[:mention] == true && tweet["user_who_posted"]["screen_name"] == @screen_name }
    @extractor.extract_ids(@mentions_arr)
  end

  def count_tweets
    counts = {
      tweets_count: @tweets_arr.length,
      retweets_count: @retweets_arr.length,
      mentions_count: @mentions_arr.length
    }
  end

end