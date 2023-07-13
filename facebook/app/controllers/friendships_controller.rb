class FriendshipsController < ApplicationController
  def index
    @friends = current_user.friends
    @requests_sent = current_user.sent_friendships.where(approved: false)
    @requests_received = current_user.received_friendships.where(approved: false)
  end

  def create
    @friendship = Friendship.new(sender_id: current_user.id, receiver_id: params[:receiver_id])
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
    if @friendship.update(approved: true)
      flash[:notice] = 'Friendship Accepted!'
      redirect_to friendships_index_path
    else
      flash[:warning] = 'Something Went Wrong :/'
      redirect_to friendships_index_path
    end
  end
end
