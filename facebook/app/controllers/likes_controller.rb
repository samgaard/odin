class LikesController < ApplicationController

  def create
    @like = Like.new(like_params)
    if @like.save!
      redirect_to posts_path
    else
      flash[:warning] = 'Something Went Wrong :/'
      redirect_to posts_path
    end
  end

  def destroy
  end

  private

  def like_params
    params.permit(:friend_id, :post_id)
  end
end
