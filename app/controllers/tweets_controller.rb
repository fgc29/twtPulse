require 'streamer/sse'

class TweetsController < ApplicationController
  include ActionController::Live

  def index
  end

  def start
    response.headers['Content-Type'] = 'text/javascript'
    client = Tweet.get_user(current_user)
    client.sample do |tweet|
      if tweet.is_a?(Twitter::Tweet) && !tweet.geo.nil?
        p 'fetching tweets'
        p tweet.geo["coordinates"]
        $redis.publish('tweets.create', tweet.geo["coordinates"].to_json)
      end

    end

    render nothing: true
  end

  def home
    render layout: 'application', text: ''
  end

  def results
    # @twitter_user = Tweet.get_user(current_user)
    response.headers['Content-Type'] = 'text/event-stream'
      sse = Streamer::SSE.new(response.stream)
      redis = Redis.new
      redis.subscribe('tweets.create') do |on|
        on.message do |event, data|
          sse.write(data, event: 'tweets.create')
        end
      end
      render nothing: true
    rescue IOError
      # Client disconnected
    ensure
      redis.quit
      sse.close
    # end
  end
  # private
  # def twitter_params
  #   params.require(:tweet).permit(:message)
  # end
end
