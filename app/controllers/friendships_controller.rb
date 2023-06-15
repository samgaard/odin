class FriendshipsController < ApplicationController
  def index
    # @friendships = Friendship.where("(sender_id = :user_id OR receiver_id = :user_id) AND approved = true", user_id: current_user.id)
    @friends = current_user.friends
    @requests_sent = current_user.sent_friendships.where(approved: false)
    @requests_received = current_user.received_friendships.where(approved: false)
  end

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice] = 'Friend Request Sent!'
      redirect_to friendships_index_path
    else
      flash[:warning] = 'Something Went Wrong :/'
      redirect_to friendships_index_path
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    if params[:approved]
      @friendship.update(approved: true)
      flash[:notice] = 'Friendship Accepted!'
      redirect_to friendships_index_path
    else
      flash[:warning] = 'Something Went Wrong :/'
      redirect_to friendships_index_path
    end
  end
end
