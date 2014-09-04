require 'csv'
require 'json'

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
      if tweet.is_a?(Twitter::Tweet) && cnt < 10 && !tweet.geo.nil?
        cnt += 1
        p 'fetching tweet data'
        # arr.push(tweet.place["country_code"])
        # arr.push(tweet.place["full_name"])
        # arr.push(tweet.place["country"])
        # arr.push(tweet.geo["coordinates"].reverse)
        arr.push(tweet.geo["coordinates"].reverse)
      elsif arr.size === 10
        CSV.open('app/assets/javascripts/city.csv', 'w', :write_headers=> true,
    :headers => ["lat", "lon"]) do |csv_object|
          arr.each do |row_array|
            csv_object << [row_array[0], row_array[1]]
          end
        end
        return false
      end
    end
  end

  def self.tweet(tweet)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.config.twitter_key
      config.consumer_secret     = Rails.application.config.twitter_secret
      config.access_token        = user.oauth_token
      config.access_token_secret = user.oauth_secret
    end
    client.update(tweet)
  end

end
