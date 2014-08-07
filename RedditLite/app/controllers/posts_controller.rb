class PostsController < ApplicationController

  before_filter :require_post_ownership!, only: [:edit, :destroy]
  before_filter :require_signed_in!, except: [:show]

  def new
    @post = Post.new
    @sub = Sub.find(params[:sub_id])
    render :new
  end

  def create
    @sub = Sub.find(params[:sub_id])
    @post = Post.new(post_params)
    @post.sub_ids = post_params[:sub_ids]
    @post.author = current_user
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to sub_url(@post.sub)
  end

  def show
    @post = Post.find(params[:id])
    # @all_comments = @post.comments.includes(:author)
    @all_comments = @post.comments_by_parent_id
    render :show
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end




end
