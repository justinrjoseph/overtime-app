class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
  def index
    @posts = Post.those_by(current_user).page(params[:page]).per(10)
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      redirect_to @post, notice: 'Post created successfully.'
    else
      render :new, error: 'There was a problem creating your post.'
    end
  end
  
  def show
  end
  
  def edit
    authorize @post
  end
  
  def update
    authorize @post
    
    if @post.update(post_params)
      redirect_to @post, notice: 'Post updated successfully.'
    else
      render :edit, error: 'There was a problem updating the post.'
    end
  end
  
  def destroy
    if @post.delete
      redirect_to posts_path, notice: "'#{@post.rationale}' was deleted."
    else
      redirect_to posts_path, error: "There was a problem deleting #{@post.rationale}"
    end
  end
  
  private
  
    def post_params
      params.require(:post).permit(:overtime_request, :date, :rationale, :status)
    end
    
    def set_post
      @post = Post.find(params[:id])
    end
end
