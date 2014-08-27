class TwitterLoader

  def self.clear_user_data
    Tweet.destroy_all
    Friend.destroy_all
    Follower.destroy_all
    User.destroy_all
  end

  def self.create_tweet_objects(parsed_tweets, mention_value)
    parsed_tweets.each do |tweet|
      Tweet.create(
        id_str: tweet["id_str"],
        tweet_created_at: tweet["created_at"].to_datetime,
        tweet_text: tweet["text"],
        user_who_posted: tweet["user"],
        retweeted_status: tweet["retweeted_status"],
        retweeted: tweet["retweeted"],
        mention: mention_value
        )
      Tweet.order(:tweet_created_at)
    end
  end

  def self.add_user_properties(user)
    User.all[0].update_attributes( screen_name: user["screen_name"] )
  end

  def self.create_friends(friends_objects)
    friends_objects["users"].each do |friend|
      Friend.create( screen_name: friend["screen_name"] )
    end
  end

  def self.create_followers(followers_objects)
    followers_objects["users"].each do |follower|
      Follower.create(screen_name: follower["screen_name"] )
    end
  end
end