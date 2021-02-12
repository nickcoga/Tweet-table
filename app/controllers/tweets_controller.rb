class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all.reverse
  end

  def new; end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    @tweets = Tweet.find_by(id: tweet_params[:replied_to_id])
    authorize @tweet
    if @tweet.save
      redirects(@tweets, tweet_params)
    else
      flash[:notice] = 'Error cannot be more than 140 characteres'
      redirect_to root_path
    end
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def show
    @response_tweet = Tweet.find(params[:id])
    @tweets = Tweet.where('replied_to_id=?', @response_tweet.id).reverse
  end

  def update
    @tweet = Tweet.find(params[:id])
    @tweets = Tweet.find_by(id: @tweet[:replied_to_id])
    authorize @tweet
    if @tweet.update(tweet_params)
      redirects(@tweets, @tweet)
      # redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    authorize @tweet
    @tweet.destroy

    @tweets = Tweet.find_by(id: @tweet[:replied_to_id])
    redirects(@tweets, @tweet)
    # redirect_to tweets_path
  end

  # Para el boton cancel
  before_action :redirect_cancel, only: [:create]

  private

  def tweet_params
    params.require(:tweet).permit(:body, current_user.id, :replied_to_id)
  end

  def redirects(tweets, tweet_params)
    if tweet_params[:replied_to_id].nil?
      redirect_to root_path
    else
      redirect_to tweet_path(tweets)
    end
  end

  def redirect_cancel
    redirect_to if params[:cancel] # si tiene ese parametro redirigir a una pagina. (index_game)
  end
end
