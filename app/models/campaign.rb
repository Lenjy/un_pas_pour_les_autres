class Campaign < ApplicationRecord
  belongs_to :charity_event
  has_many :entreprises
end
