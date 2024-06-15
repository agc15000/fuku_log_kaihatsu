class Cloth < ApplicationRecord
  belongs_to :user
  has_many :episodes, dependent: :destroy
  acts_as_taggable_on :tags
end