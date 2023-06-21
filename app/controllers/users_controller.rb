# app/controllers/users_controller.rb

class UsersController < ApplicationController
  def index
    @users = User.all
    @friend_ids = current_user.friends.pluck(:id)
    @requests_sent_ids = current_user.pending_friendship_requests.pluck(:receiver_id)
    @requests_received_ids = current_user.pending_friendship_invitations.pluck(:sender_id)
  end

  def show
    @users = User.find(params[:id])
  end
end
