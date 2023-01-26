class CommentsController < ApplicationController
  
  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to post_path(params[:post_id] )
    else
      @post = Post.find(params[:post_id])
      @comments = @post.comments.page(params[:page]).per(7).reverse_order
      render 'posts/show'
    end
  end

  def destroy
    comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
    comment.destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment).merge(post_id: params[:post_id])

  end

end
