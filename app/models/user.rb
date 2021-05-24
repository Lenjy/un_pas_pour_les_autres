class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :enterprise, optional: true
  has_many :teams, through: :joined_team
  has_many :campaigns, through: :joined_campaign
  has_one_attached :photo
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true
  validates :address, presence: true
  validates :nickname, presence: true, uniqueness: true

end
 