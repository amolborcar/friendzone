class NetworksController < ApplicationController

  def index
  end

  def sign_in
    session[:request_token] = Authorizer.request_token(session[:request_token], request.host)
    redirect_to session[:request_token].authorize_url
  end

  def sign_out
    TwitterLoader.clear_user_data
    session.clear
    redirect_to root_path
  end

  def auth
    @access_token = Authorizer.request_token(session[:request_token], request.host).get_access_token(:oauth_verifier => params[:oauth_verifier])
    session.delete(:request_token)
    Authorizer.save_token(@access_token)
    redirect_to load_path
  end

  def load
    fetcher = DataFetcher.new(Authorizer.instantiate_token)
    fetcher.get_twitter_data
    redirect_to root_path
  end

  def search
    filterer = TwitterFilter.new
    @name = params[:name]
    @screen_name = filterer.find_screen_name_by_name(@name)
    @my_tweets = filterer.filter_tweets_by_name
    @retweets = filterer.filter_retweets_by_name
    @mentions = filterer.filter_mentions_by_name(User.first.screen_name)
    render partial: 'tweets/embedded'
  end

  def find_all_names
    friends = Friend.pluck(:name)
    followers = Follower.pluck(:name)
    render :json => (friends+followers).uniq.sort
  end

end
