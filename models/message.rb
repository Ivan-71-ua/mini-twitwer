class Message < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  has_many :comments

  validates :content, presence: true, length: { maximum: 280 }
end
