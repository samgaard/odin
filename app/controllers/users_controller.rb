# app/controllers/users_controller.rb

class UsersController < ApplicationController
  def index
    @users = User.all
    @friend_ids = current_user.friends.pluck(:id)
    @requests_sent_ids = current_user.pending_friendship_requests.pluck(:receiver_id)
    @requests_received_ids = current_user.pending_friendship_invitations.pluck(:sender_id)

    # @friendships = current_user.received_friendships.where(approved: true)
    # @friendships_user_ids = @friendships.pluck(:sender_id, :receiver_id).flatten.uniq
    # Friendship.where("(user_id = :user_id OR friend_id = :user_id) AND approved = TRUE", user_id: .id)
    # @friendships_user_ids = @friendships.pluck(:user_id, :friend_id).flatten.uniq
    # @requests_sent = Friendship.where(user_id: current_user.id, approved: false)
    # @requests_sent_user_ids = @requests_sent.pluck(:user_id, :friend_id).flatten.uniq
    # @requests_received = Friendship.where(friend_id: current_user.id, approved: false)
    # @requests_received_user_ids = @requests_received.pluck(:user_id, :friend_id).flatten.uniq
  end

  def show
    @users = User.find(params[:id])
  end
end
