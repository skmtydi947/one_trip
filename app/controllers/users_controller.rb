class UsersController < ApplicationController
  before_action :check_guest, only: %i[edit destroy]

  def check_guest
    @user = User.find(params[:id])
    if @user.email == 'guest@example.com'
      redirect_to user_path(@user.id)
      flash[:notice] = 'ゲストユーザーは編集・退会できません。'
    end
  end

  def index
    @users = User.page(params[:page]).includes(:posts).per(3).reverse_order
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).includes(:favorites, :user, :post_images, :comments).reverse_order
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to :root
  end

  def follows
    user = User.find(params[:id])
    @users = user.following_user.page(params[:page]).per(3).reverse_order
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_user.page(params[:page]).per(3).reverse_order
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile, :profile_image)
  end
end
