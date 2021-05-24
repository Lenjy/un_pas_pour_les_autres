class Campaign < ApplicationRecord
  belongs_to :charity_event
  belongs_to :enterprise
  has_many :teams
  has_many :joined_campaigns

end
