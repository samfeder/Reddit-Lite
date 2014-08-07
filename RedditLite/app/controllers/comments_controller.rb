class CommentsController < ApplicationController

  def new
  end

  def create
    if comment_params[:post_id].nil?
      @comment = Comment.new(comment_params)
      # @comment.parent_comment_id = comment_params[:parent_comment_id]
      @comment.post_id = Comment.find(comment_params[:parent_comment_id]).post_id
    else
      @post = Post.find(comment_params[:post_id])
      @comment = @post.comments.new(comment_params)
    end
    @comment.author = current_user
    @comment.save
    flash[:errors] = @comment.errors.full_messages
    redirect_to post_url(@comment.post)
  end

  def show
    @comment = Comment.find(params[:id])
    render :show
  end

  def edit
  end

  def update
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_url(@comment.post)
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :parent_comment_id, :post_id)
  end


end
