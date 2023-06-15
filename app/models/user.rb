class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sent_friendships, class_name: 'Friendship', foreign_key: 'sender_id'
  has_many :received_friendships, class_name: 'Friendship', foreign_key: 'receiver_id'

  def friends
    sent_friendships.where(approved: true).or(received_friendships.where(approved: true))
  end

  # has_many :friendships, through: :sent_friendships, source: :receiver
  #
  # has_many :inverse_friendships, ->(user) { where("sender_id = :user_id OR receiver_id = :user_id", user_id: user.id).where(status: 'accepted') },
  #          through: :received_friendships, source: :sender
  #
  def pending_friendship_invitation
    received_friendships.where(approved: false)
  end

  # def all_friendships
  #   friendships.or(inverse_friendships)
  # end

  # has_many :friendships, ->(user) { where("sender_id = :user_id OR receiver_id = :user_id", user_id: user.id) }
  # has_many :friends, through: :friendships

  # def is_friend(friend_id)
  #   friendships.exists?(friend_id: friend_id, approved: true)
  # end
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
