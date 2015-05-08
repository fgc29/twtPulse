require 'redis'
require 'json'

class Tweet

  def self.get_user(user)

    Twitter::Streaming::Client.new do |config|
      config.consumer_key        = Rails.application.config.twitter_key
      config.consumer_secret     = Rails.application.config.twitter_secret
      config.access_token        = user.oauth_token
      config.access_token_secret = user.oauth_secret
    end
  end

end
