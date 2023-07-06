class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sent_friendships, class_name: 'Friendship', foreign_key: 'sender_id'
  has_many :received_friendships, class_name: 'Friendship', foreign_key: 'receiver_id'
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :likes, foreign_key: :friend_id

  def friends
    user_ids = sent_friendships.where(approved: true).or(received_friendships.where(approved: true)).pluck(:sender_id, :receiver_id).flatten.uniq
    filtered_user_ids = user_ids.reject { |id| id === self.id }
    User.where(id: filtered_user_ids)
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

  # has_many :friendships, through: :sent_friendships, source: :receiver
  #
  # has_many :inverse_friendships, ->(user) { where("sender_id = :user_id OR receiver_id = :user_id", user_id: user.id).where(status: 'accepted') },
  #          through: :received_friendships, source: :sender
  #
  # def all_friendships
  #   friendships.or(inverse_friendships)
  # end

  # has_many :friendships, ->(user) { where("sender_id = :user_id OR receiver_id = :user_id", user_id: user.id) }
  # has_many :friends, through: :friendships

  def is_friend(friend_id)
    friends.exists?(id: friend_id)
  end

  #
  # def sent_friend_request(friend_id)
  #   friendships.exists?(friend_id: friend_id, approved: false)
  # end
  #
  # def received_friend_request(friend_id)
  #   friendship_exists = Friendship.where(user_id: friend_id, friend_id: self.id, approved: false)
  #   friendship_exists.length > 0
  # end
end