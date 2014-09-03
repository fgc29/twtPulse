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
      if tweet.is_a?(Twitter::Tweet) && cnt < 2 && !tweet.geo.nil?
        cnt += 1
        p 'hi'
        # arr.push(tweet.geo["coordinates"])
        arr.push(tweet.to_hash)
      elsif arr.size === 2
        return arr
      end
    end
  end
end
