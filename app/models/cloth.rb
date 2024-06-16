class Cloth < ApplicationRecord
  belongs_to :user
  has_many :episodes, dependent: :destroy
  acts_as_taggable_on :tags
  mount_uploader :image, ImageUploader

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "image", "name", "updated_at", "user_id"]
  end
  
end