class Tweet
  def self.get_user(user)
    client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = Rails.application.config.twitter_key
      config.consumer_secret     = Rails.application.config.twitter_secret
      config.access_token        = user.oauth_token
      config.access_token_secret = user.oauth_secret
    end

    cnt = 0
    arr = []
    client.sample do |tweet|
      if tweet.is_a?(Twitter::Tweet) && cnt < 50 && !tweet.geo.nil?
        cnt += 1
        p 'fetching tweet data'
        arr.push(tweet.geo["coordinates"].reverse)
        # arr.push(tweet.to_hash)
      elsif arr.size === 50
        return arr
      end
    end
  end
end
