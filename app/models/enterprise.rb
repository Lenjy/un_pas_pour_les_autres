class Enterprise < ApplicationRecord
  has_many :campaigns
  has_many :users
  has_many :steps, through: :users
  validates :name, presence: true
  has_one_attached :photo
end
