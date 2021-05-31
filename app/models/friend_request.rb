class FriendRequest < ApplicationRecord
  enum status: [:pending, :accepted, :declined]
  belongs_to :asker, class_name: "User" 
  belongs_to :receiver, class_name: "User"
end
