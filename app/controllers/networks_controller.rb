class NetworksController < ApplicationController

  def index
  end

  def sign_out
    TwitterLoader.clear_user_data
    session.clear
    redirect_to root_path
  end

  def sign_in_twitter
    session[:request_token] = Authorizer.request_token(session[:request_token], request.host)
    redirect_to session[:request_token].authorize_url
  end

  # def sign_in_facebook
  #   facebook_client = Authorizer.create_facebook_client(request.host)
  #   redirect_to Authorizer.authorize_facebook_request(facebook_client)
  #   # redirect_to session[:facebook_request]
  # end

  def auth_twitter
    @access_token = Authorizer.request_token(session[:request_token], request.host).get_access_token(:oauth_verifier => params[:oauth_verifier])
    session.delete(:request_token)
    Authorizer.save_token(@access_token)
    redirect_to load_twitter_path
  end

  # def auth_facebook
  #   client = Authorizer.create_facebook_client(request.host)
  #   @facebook_token = client.authorize(:code => params[:code])
  #   puts @facebook_token
  #   puts client.me.home
  # end

  def load_twitter
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
    @counts = filterer.count_tweets
    render partial: 'tweets/embedded'
  end

  def find_all_names
    friends = Friend.pluck(:name)
    followers = Follower.pluck(:name)
    render :json => (friends+followers).uniq.sort
  end

end
