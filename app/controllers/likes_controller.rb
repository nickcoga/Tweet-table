class LikesController < ApplicationController
  before_action :find_tweet
  before_action :find_like, only: [:destroy]

  def create
    @tweets = Tweet.find_by(id: @tweet.replied_to_id)
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      # authorize @like
      @tweet.likes.create(user_id: current_user.id)

    end

    redirects(@tweets)
  end

  def destroy
    if already_liked?
      @like.destroy
    else
      flash[:notice] = 'Cannot unlike'
    end
    # redirect_to profile_likes_user_path(current_user)
    redirect_to root_path
  end

  private

  def find_like
    @like = @tweet.likes.find(params[:id])
  end

  def find_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def redirects(_tweets)
    if @tweet.replied_to_id.nil?
      redirect_to root_path
    else
      redirect_to tweet_path(@tweet.replied_to)
    end
  end

  def already_liked?
    Like.exists?(user_id: current_user.id, tweet_id:
    params[:tweet_id])
  end
end
