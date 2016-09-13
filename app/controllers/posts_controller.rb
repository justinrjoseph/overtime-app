class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
  def index
    @posts = Post.all
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
  
  private
  
    def post_params
      params.require(:post).permit(:date, :rationale)
    end
    
    def set_post
      @post = Post.find(params[:id])
    end
end
