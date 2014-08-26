class Tweet < ActiveRecord::Base
  attr_accessible :id_str, :tweet_created_at, :tweet_text, :user_who_posted, :retweeted_status, :retweeted, :mention
  serialize :id_str
  serialize :user_who_posted
  serialize :retweeted_status
  serialize :retweeted
end
