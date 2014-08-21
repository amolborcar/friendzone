class Authorizer

  def self.oauth_consumer
    raise RuntimeError, "You must set TWITTER_KEY and TWITTER_SECRET in your server environment." unless ENV['TWITTER_KEY'] and ENV['TWITTER_SECRET']
    @consumer ||= OAuth::Consumer.new(
      ENV['TWITTER_KEY'],
      ENV['TWITTER_SECRET'],
      :site => "https://api.twitter.com"
      )
  end

  def self.request_token(request_token, host)
    if not request_token
      host_and_port = host
      host_and_port << ":3000" if host == "localhost"
      request_token = Authorizer.oauth_consumer.get_request_token(
        # This redirects to the /auth route
        :oauth_callback => "http://#{host_and_port}/auth")
    end
    request_token
  end

  def self.save_token(access_token)
    User.create(token_key: access_token.token, token_secret: access_token.secret)
  end

  def self.instantiate_token
    OAuth::AccessToken.new(
      OAuth::Consumer.new(
        ENV['TWITTER_KEY'],
        ENV['TWITTER_SECRET'],
        :site => "https://api.twitter.com"
      ),
      User.all[0].token_key,
      User.all[0].token_secret
    )
  end
end