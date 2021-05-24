class Campaign < ApplicationRecord
  belongs_to :charity_event
  belongs_to :enterprise
end
