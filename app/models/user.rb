class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cloths, dependent: :destroy
  has_many :episodes, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at updated_at]
  end
end
