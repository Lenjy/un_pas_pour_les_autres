require 'google/apis/fitness_v1'
require 'googleauth'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :enterprise, optional: true
  has_many :joined_teams
  has_many :teams, through: :joined_teams
  has_many :campaigns, through: :joined_campaign
  has_many :steps
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
    
    # fitness = Google::Apis::FitnessV1::FitnessService.new
    # fitness.authorization =  access_token.credentials.token

    # aggregate_by = Google::Apis::FitnessV1::AggregateBy.new
    # aggregate_by.data_type_name = 'com.google.step_count.delta'
    # aggregate_by.data_source_id = 'derived:com.google.step_count.delta:com.google.android.gms:estimated_steps'

    # bucket_by_time = Google::Apis::FitnessV1::BucketByTime.new
    # bucket_by_time.duration_millis = 86400000

    # aggregate_request = Google::Apis::FitnessV1::AggregateRequest.new
    # aggregate_request.aggregate_by = [aggregate_by]
    # aggregate_request.bucket_by_time = bucket_by_time
    # aggregate_request.start_time_millis = (Time.new(Time.now.year, Time.now.month, Time.now.day, 0, 0, 0).to_f * 1000).to_i
    # aggregate_request.end_time_millis = (Time.new(Time.now.year, Time.now.month, Time.now.day, 23, 59, 0).to_f * 1000).to_i

    # # daily_step = fitness.aggregate_dataset('me', aggregate_request)
    # # raise
    
    # response = HTTParty.post("https://www.googleapis.com/fitness/v1/users/me/dataset:aggregate",
    #           :headers => {'Content-Type' => 'application/json', 'Authorization' => "Bearer #{access_token.credentials.token}"},
    #           :body => aggregate_request.to_json
    # )

    # if !JSON.parse(response.body)["bucket"].nil?
    #   # if user.steps.include?
    #   daily_step = JSON.parse(response.body)["bucket"][0]["dataset"][0]["point"][0]["value"][0]["intVal"]
    # else
    #   daily_step=0
    # end
    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(first_name: data['first_name'],
          last_name: data['last_name'],
          email: data['email'],
          password: Devise.friendly_token[0,20]
        )
    end
    user.token = access_token.credentials.token
    user
  end


end
