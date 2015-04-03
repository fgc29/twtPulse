class TweetsController < ApplicationController
  def index
  end

  def home
    render layout: 'application', text: ''
  end
  # def new
  # end
  #
  # def create
  #   current_user.tweet(twitter_params[:message])
  # end

  # def search
  #   render :search
  # end

  def results
    @twitter_user = Tweet.get_user(current_user)
    # binding.pry
    render json: @twitter_user
    # render layout: 'application', text: ''
  end
  # private
  # def twitter_params
  #   params.require(:tweet).permit(:message)
  # end
end
