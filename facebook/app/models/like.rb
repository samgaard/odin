class Like < ApplicationRecord
  belongs_to :friend, class_name: 'User'
  belongs_to :post, dependent: :destroy
  # validate :friendship_required
  # def friendship_required
  #   errors.add(:base, 'Friendship required to like posts') unless post.author.is_friend(friend.id)
  # end
end
