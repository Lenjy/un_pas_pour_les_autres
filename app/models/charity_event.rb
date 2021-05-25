class CharityEvent < ApplicationRecord
  has_many :campaigns
  validates :title, presence: true
  validates :charity_name, presence: true
  validates :date_beginning, presence: true
  validates :date_ending, presence: true
  validates :total_donation, presence: true
end
