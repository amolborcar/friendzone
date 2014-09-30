class TwitterData
  def initialize
    @tweet_dates = {}
    # populate dates hash with year/month combinations to be counted later
    years = (2005..2014).to_a
    months = (01..12).to_a
    years.each do |year|
      months.each do |month|
        @tweet_dates["#{month} #{year}"] = 0;
      end
    end
  end

  def count_dates_of_tweets
    Tweet.all.each do |tweet|
      @tweet_dates["#{tweet['tweet_created_at'].month} #{tweet['tweet_created_at'].year}"]+= 1
    end
    # dates = @tweet_dates.map do |pair|
      # TODO: translate date strings into Date format using regex
    # end
    return { dates: @tweet_dates.keys, values: @tweet_dates.values }
  end

  def get_sentiment_of_tweets
    # Call the HP Sentiment API on text of all tweets
    Tweet.all.each do |tweet|
      # sentiment = HTTParty.get('https://api.idolondemand.com/1/api/sync/analyzesentiment/v1', :headers => { :text => "#{tweet['tweet_text']}", :apikey => "#{ENV['HP_KEY']}"})
      # uri_text = tweet['tweet_text'].gsub(/["#@&$^%*;,_!.?:\/]/, "")
      uri_text = tweet['tweet_text'].gsub(/~(?i)\b((?:[a-z][\w-]+:(?:/{1,3}|[a-z0-9%])|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:\'".,<>?«»“”‘’]))~/, '')
      # uri_text.gsub!(/\s/, '+')
      p uri_text
      # p uri_text
      # sentiment = HTTParty.get("https://api.idolondemand.com/1/api/sync/analyzesentiment/v1?text=#{uri_text}&apikey=#{ENV['HP_KEY']}")
      sentiment = HTTParty.get("https://api.idolondemand.com/1/api/sync/analyzesentiment/v1?text=#{uri_text}&apikey=b56bb8ab-168e-4b67-90f2-4b795da2481b")
      # p sentiment
      # @tweet_dates["#{tweet['tweet_created_at'].month} #{tweet['tweet_created_at'].year}"] += sentiment['aggregate']['score']
    end

  end

end