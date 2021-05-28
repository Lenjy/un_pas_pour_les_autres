class DonationPayment < ApplicationRecord
  belongs_to :user
  belongs_to :charity_event
  monetize :amount_cents
end
