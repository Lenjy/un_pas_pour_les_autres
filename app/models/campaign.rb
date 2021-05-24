class Campaign < ApplicationRecord
  belongs_to :charity_event
  has_many :enterprises
end
