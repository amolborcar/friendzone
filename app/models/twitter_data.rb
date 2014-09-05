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

end