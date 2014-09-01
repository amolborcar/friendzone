class User < ActiveRecord::Base
  attr_accessible :name, :screen_name, :token_key, :token_secret
end