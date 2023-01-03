class PostsController < ApplicationController

  def new
    @post = Post.new  
  end

  def create
    post = Post.new(post_params)
    if post.save
    redirect_to post_path(post.id)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
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
