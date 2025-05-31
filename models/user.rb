
class User < ActiveRecord::Base
  has_secure_password

  has_many :sent_messages, class_name: 'PrivateMessage', foreign_key: 'sender_id'
  has_many :received_messages, class_name: 'PrivateMessage', foreign_key: 'receiver_id'

  has_many :likes
  has_many :liked_messages, through: :likes, source: :message

  has_many :comments

  has_many :messages
  has_many :follows, foreign_key: :follower_id
  has_many :followings, through: :follows, source: :followed

  has_many :reverse_follows, class_name: 'Follow', foreign_key: :followed_id
  has_many :followers, through: :reverse_follows, source: :follower

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  def following?(other_user)
    followings.include?(other_user)
  end
end
