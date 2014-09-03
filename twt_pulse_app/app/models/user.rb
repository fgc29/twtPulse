class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider     = auth.provider
      user.uid          = auth.uid
      user.name         = auth.info.name
      user.oauth_token  = auth.credentials.token
      user.oauth_secret = auth.credentials.secret
      user.save!
    end
  end

  def tweet(tweet)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.config.twitter_key
      config.consumer_secret     = Rails.application.config.twitter_secret
      config.access_token        = oauth_token
      config.access_token_secret = oauth_secret
    end
    client.update(tweet)
  end

#   def get_user(uid)
#     client = Twitter::REST::Client.new do |config|
#       config.consumer_key        = Rails.application.config.twitter_key
#       config.consumer_secret     = Rails.application.config.twitter_secret
#       config.access_token        = oauth_token
#       config.access_token_secret = oauth_secret
#     end
#
#     # client.sample do |object|
#     #   # object.user.location if object.is_a?(Twitter::Tweet)
#     #   puts object.to_hash if object.is_a?(Twitter::Tweet)
#     #   end
#     # end
#     client.search("#{uid}", :result_type => "recent").take(1000).collect do |tweet|
#   "#{tweet.user.screen_name}: #{tweet.to_hash}"
# end
#   end

  # def get_user(uid)
  #   client = Twitter::Streaming::Client.new do |config|
  #     config.consumer_key        = Rails.application.config.twitter_key
  #     config.consumer_secret     = Rails.application.config.twitter_secret
  #     config.access_token        = oauth_token
  #     config.access_token_secret = oauth_secret
  #   end
  #
  #   cnt = 0
  #   arr = []
  #   client.sample do |tweet|
  #     if tweet.is_a?(Twitter::Tweet) && cnt < 2 && !tweet.geo.nil?
  #       cnt += 1
  #       p 'hi'
  #       # arr.push(tweet.geo["coordinates"])
  #       arr.push(tweet.to_hash)
  #     elsif arr.size === 2
  #       return arr
  #     end
  #   end
  # end

end
