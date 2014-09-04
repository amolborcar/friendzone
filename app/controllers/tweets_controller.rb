class TweetsController < ApplicationController

  def get_dates_of_tweets
    data_analyzer = TwitterData.new
    render :json => data_analyzer.count_dates_of_tweets
  end
end