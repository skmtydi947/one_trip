class FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    unless current_user == @post.user
      favorite = current_user.favorites.new(post_id: @post.id)
      favorite.save
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end
end