class User < ActiveRecord::Base
  attr_accessible :screen_name, :token_key, :token_secret

end