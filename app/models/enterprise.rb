class Enterprise < ApplicationRecord
  has_many :campaigns
  validates :name, presence: true
end
