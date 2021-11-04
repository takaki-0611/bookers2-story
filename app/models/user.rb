class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :followers, source: :followed
  has_many :follower_user, through: :followeds, source: :follower
  attachment :profile_image, destroy: false

  def follow(user_id)
    self.followers.find_or_create_by(followed_id: user_id)
  end

  def unfollow(user_id)
    self.followers.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following_user.include?(user)
  end

  validates :introduction, length: {maximum: 50}
  validates :name, presence: true, length: {maximum: 20, minimum: 2}, uniqueness: true
end
