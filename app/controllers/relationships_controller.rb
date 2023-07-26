class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end
  
  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(params[:user_id])
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end
  
end
