class NetworksController < ApplicationController

  def index
  end

  def search
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
    @token = Authorizer.instantiate_token
    @timeline = JSON.parse(@token.get('https://api.twitter.com/1.1/statuses/user_timeline.json?count=200').body)
    @mentions = JSON.parse(@token.get('https://api.twitter.com/1.1/statuses/mentions_timeline.json?count=200').body)
    @user = JSON.parse(@token.get('https://api.twitter.com/1.1/account/verify_credentials.json').body)
    @friends = JSON.parse(@token.get('https://api.twitter.com/1.1/friends/list.json?count=200').body)
    @followers = JSON.parse(@token.get('https://api.twitter.com/1.1/followers/list.json?count=200').body)
    # helper methods to load tweets into database
    TwitterLoader.create_tweet_objects(@timeline, false)
    TwitterLoader.create_tweet_objects(@mentions, true)
    TwitterLoader.add_user_properties(@user)
    TwitterLoader.create_friends(@friends)
    TwitterLoader.create_followers(@followers)
    redirect_to index_path
  end

end
