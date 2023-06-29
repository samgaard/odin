class Friendship < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validate :cannot_send_friend_request_to_self

  def cannot_send_friend_request_to_self
    errors.add(:base, 'Cannot send friend request to yourself') if sender == receiver
  end
end
