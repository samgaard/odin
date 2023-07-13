class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params.merge(user: current_user))
    if @comment.save
      redirect_to post_path(@post)
    else
      flash[:warning] = 'Something Went Wrong :/'
      redirect_to posts_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
