class FavoritesController < ApplicationController

  def create
    favorite = current_user.favorites.new(post_id: params[:post_id])
    favorite.save
    redirect_to post_path(params[:post_id])
  end
  
  def destroy
    favorite = current_user.favorites.find_by(post_id: params[:post_id])
    favorite.destroy
    redirect_to post_path(params[:post_id])
  end

end
