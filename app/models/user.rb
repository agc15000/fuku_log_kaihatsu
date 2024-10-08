class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cloths, dependent: :destroy
  has_many :episodes, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :entries
  has_many :rooms, through: :entries
  has_many :messages

  def follow(user)
    active_relationships.find_or_create_by(followed_id: user.id)
  end

  def unfollow(user)
    relationship = active_relationships.find_by(followed_id: user.id)
    relationship.destroy if relationship
  end

  def following?(user)
    active_relationships.exists?(followed_id: user.id)
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at updated_at]
  end
end
