require 'google/apis/fitness_v1'
require 'googleauth'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :enterprise, optional: true
  has_many :joined_teams
  has_many :teams, through: :joined_teams
  has_many :joined_campaigns
  has_many :campaigns, through: :joined_campaign
  has_many :steps
  has_many :donation_payments
  has_one_attached :photo

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  validates :first_name, presence: true
  validates :last_name, presence: true
  # validates :phone_number, presence: true
  # validates :address, presence: true
  # validates :nickname, presence: true, uniqueness: true


  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    unless user
        user = User.create!(first_name: data['first_name'],
          last_name: data['last_name'],
          email: data['email'],
          password: Devise.friendly_token[0,20],
          token: access_token.credentials.token
        )
        FitnessApi.new(user, user.token).get_info_month
    end

    user.update!( token: access_token.credentials.token)

    if user.steps.where( date: Date.today) != []
      today = user.steps.where( date: Date.today).first
      today.nb_steps = FitnessApi.new(user, user.token).get_daily_step
      today.save!
    else
      Step.create!(user: user, nb_steps: FitnessApi.new(user, user.token).get_daily_step, date: Date.today)
    end

    return user
  end


end
