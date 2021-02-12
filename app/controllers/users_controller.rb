class UsersController < ApplicationController
  before_action :set_user

  def profile_tweets; end

  def profile_likes; end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
