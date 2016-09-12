class PostsController < ApplicationController
  def index
    
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    
    if @post.save
      redirect_to @post
    else
      flash[:error] = 'There was a problem creating your post.'
      render :new
    end
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  private
  
    def post_params
      params.require(:post).permit(:date, :rationale)
    end
end
