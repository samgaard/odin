class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :friendship_invitations_check

  private

  def friendship_invitations_check
    return unless current_user

    @friendship_invitations = current_user.pending_friendship_invitations.count
  end
end
