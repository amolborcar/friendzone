class TweetsController < ApplicationController

  def get_dates_of_tweets
    data_analyzer = TwitterData.new
    date_count = data_analyzer.count_dates_of_tweets
    render :json => date_count
  end
end