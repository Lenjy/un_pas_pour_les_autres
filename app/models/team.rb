class Team < ApplicationRecord
  belongs_to :campaign
  has_many :joined_teams
  has_many :users, through: :joined_teams
  has_many :steps, through: :users

  has_one_attached :photo

  validates :name, presence: true, uniqueness: true, length: { in: 5..30 }
  validates :description, length: { maximum: 100 }
end
