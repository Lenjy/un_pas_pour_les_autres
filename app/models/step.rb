class Step < ApplicationRecord
  belongs_to :user
  validates :date, presence: true
  validates :nb_steps, presence: true
end
