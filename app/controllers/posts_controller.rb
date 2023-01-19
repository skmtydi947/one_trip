class PostsController < ApplicationController

  def new
    @post = Post.new  
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    if post.save
    redirect_to post_path(post.id)
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.page(params[:page]).per(7).reverse_order
  end

  def index
    @posts = Post.page(params[:page]).reverse_order
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
    redirect_to post_path(post.id)
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
    redirect_to posts_path
    end
  end

  private
  def post_params
    params.require(:post).permit(:location, :text, :image)
  end

end
