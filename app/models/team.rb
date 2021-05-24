class Team < ApplicationRecord
  belongs_to :campaign
  belongs_to :joined_team
  has_many :users, through: :joined_teams

  has_one_attached :photo

  validates :name, presence: true, uniqueness: true, length: { in: 5..30 }
  validates :description, length: { maximum: 100 }
end
