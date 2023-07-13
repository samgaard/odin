class PostsController < ApplicationController
  def index
    @posts = current_user.timeline_posts
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save!
      redirect_to posts_path
    else
      flash[:warning] = 'Something Went Wrong :/'
      redirect_to posts_path
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

end
