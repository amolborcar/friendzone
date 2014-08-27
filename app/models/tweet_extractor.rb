class TweetExtractor

  def extract_ids(tweet_objects)
    new_arr = tweet_objects.map { |tweet| tweet["id_str"]}
    get_embedded_tweets(new_arr)
  end

  def get_embedded_tweets(tweet_ids)
    tweet_arr = []
    tweet_ids.each do |id|
      tweet_arr << JSON.parse(HTTParty.get("https://api.twitter.com/1/statuses/oembed.json?id=#{id}").body)
    end
    tweet_arr
  end

end