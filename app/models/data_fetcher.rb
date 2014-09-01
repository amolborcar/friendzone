class DataFetcher
  def initialize(twitter_token)
    @twitter_token = twitter_token
    @timeline
    @mentions
    @user
    @friends
    @followers
  end

  def get_twitter_data
    @timeline = JSON.parse(@twitter_token.get('https://api.twitter.com/1.1/statuses/user_timeline.json?count=200').body)
    @mentions = JSON.parse(@twitter_token.get('https://api.twitter.com/1.1/statuses/mentions_timeline.json?count=200').body)
    @user = JSON.parse(@twitter_token.get('https://api.twitter.com/1.1/account/verify_credentials.json').body)
    @friends = JSON.parse(@twitter_token.get('https://api.twitter.com/1.1/friends/list.json?count=200').body)
    @followers = JSON.parse(@twitter_token.get('https://api.twitter.com/1.1/followers/list.json?count=200').body)
    save_twitter_data_to_database
  end

  def save_twitter_data_to_database
    TwitterLoader.create_tweet_objects(@timeline, false)
    TwitterLoader.create_tweet_objects(@mentions, true)
    TwitterLoader.add_user_properties(@user)
    TwitterLoader.create_friends(@friends)
    TwitterLoader.create_followers(@followers)
  end
end