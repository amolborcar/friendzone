class TwitterData
  def initialize
    @tweet_dates = {}
    # populate dates hash with year/month combinations to be counted later
    years = (2005..2014).to_a
    months = (01..12).to_a
    years.each do |year|
      months.each do |month|
        @tweet_dates["#{year}_#{month}"] = 0;
      end
    end
  end

  def count_dates_of_tweets
    Tweet.all.each do |tweet|
      @tweet_dates["#{tweet['tweet_created_at'].year}_#{tweet['tweet_created_at'].month}"]+= 1
    end
    puts @tweet_dates
  end

end