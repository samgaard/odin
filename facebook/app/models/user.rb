class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sent_friendships, class_name: 'Friendship', foreign_key: 'sender_id'
  has_many :received_friendships, class_name: 'Friendship', foreign_key: 'receiver_id'
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :likes, foreign_key: :friend_id
  has_one_attached :avatar

  def friends
    user_ids = sent_friendships
                 .where(approved: true)
                 .or(received_friendships.where(approved: true))
                 .pluck(:sender_id, :receiver_id)
                 .flatten
                 .uniq
    filtered_user_ids = user_ids.reject { |id| id == self.id }
    User.where(id: filtered_user_ids)
  end

  def timeline_posts
    Post
      .where(author_id: id)
      .or(Post.where(author_id: friends.pluck(:id)))
      .order(created_at: :desc)
  end

  def pending_friendship_invitations
    received_friendships.where(approved: false)
  end

  def pending_friendship_requests
    sent_friendships.where(approved: false)
  end

  def can_like(post)
    !post.likes.map(&:friend_id).include?(id) && post.author.id != id
  end

  def is_friend(friend_id)
    friends.exists?(id: friend_id)
  end
end
