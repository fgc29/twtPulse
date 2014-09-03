class TweetsController < ApplicationController
  def new
  end

  def create
    current_user.tweet(twitter_params[:message])
  end

  def search
    render :search
  end
  def results
    @twitter_user = current_user.get_user(tweet_params[:uid])
    render :results
  end

  def twitter_params
    params.require(:tweet).permit(:message)
  end
  def tweet_params
    params.require(:tweet).permit(:uid)
  end
end
