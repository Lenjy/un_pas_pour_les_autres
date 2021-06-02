require 'google/apis/fitness_v1'

class FitnessApi 
  def initialize(current_user, access_token)
    @user = current_user
    @access_token = access_token
  end

  def get_daily_step
    fitness = Google::Apis::FitnessV1::FitnessService.new
    fitness.authorization =  @access_token

    aggregate_by = Google::Apis::FitnessV1::AggregateBy.new
    aggregate_by.data_type_name = 'com.google.step_count.delta'
    aggregate_by.data_source_id = 'derived:com.google.step_count.delta:com.google.android.gms:estimated_steps'

    bucket_by_time = Google::Apis::FitnessV1::BucketByTime.new
    bucket_by_time.duration_millis = 86400000

    aggregate_request = Google::Apis::FitnessV1::AggregateRequest.new
    aggregate_request.aggregate_by = [aggregate_by]
    aggregate_request.bucket_by_time = bucket_by_time
    aggregate_request.start_time_millis = (Time.new(Time.now.year, Time.now.month, Time.now.day, 0, 0, 0).to_f * 1000).to_i
    aggregate_request.end_time_millis = (Time.new(Time.now.year, Time.now.month, Time.now.day, 23, 59, 0).to_f * 1000).to_i

    # daily_step = fitness.aggregate_dataset('me', aggregate_request)
    # raise
    
    response = HTTParty.post("https://www.googleapis.com/fitness/v1/users/me/dataset:aggregate",
              :headers => {'Content-Type' => 'application/json', 'Authorization' => "Bearer #{@access_token}"},
              :body => aggregate_request.to_json
    )

    if !JSON.parse(response.body)["bucket"].nil?
      # if user.steps.include?
      if JSON.parse(response.body)["bucket"][0]["dataset"][0]["point"] == []
        daily_step = 0
      else
        daily_step = JSON.parse(response.body)["bucket"][0]["dataset"][0]["point"][0]["value"][0]["intVal"]
      end
    end
  end

  def get_info_month
    fitness = Google::Apis::FitnessV1::FitnessService.new
    fitness.authorization =  @access_token
  
    aggregate_by = Google::Apis::FitnessV1::AggregateBy.new
    aggregate_by.data_type_name = 'com.google.step_count.delta'
    aggregate_by.data_source_id = 'derived:com.google.step_count.delta:com.google.android.gms:estimated_steps'
  
    bucket_by_time = Google::Apis::FitnessV1::BucketByTime.new
    bucket_by_time.duration_millis = 86400000
    date_to_check = Date.today.yesterday 
    30.times do
      aggregate_request = Google::Apis::FitnessV1::AggregateRequest.new
      aggregate_request.aggregate_by = [aggregate_by]
      aggregate_request.bucket_by_time = bucket_by_time
      aggregate_request.start_time_millis = (Time.new(date_to_check.year, date_to_check.month, date_to_check.day, 0, 0, 0).to_f * 1000).to_i
      aggregate_request.end_time_millis = (Time.new(date_to_check.year, date_to_check.month, date_to_check.day, 23, 59, 0).to_f * 1000).to_i
      

      response = HTTParty.post("https://www.googleapis.com/fitness/v1/users/me/dataset:aggregate",
                :headers => {'Content-Type' => 'application/json', 'Authorization' => "Bearer #{@access_token}"},
                :body => aggregate_request.to_json
      )

      if !JSON.parse(response.body)["bucket"].nil?
        # if user.steps.include?
        if JSON.parse(response.body)["bucket"][0]["dataset"][0]["point"] == []
          daily_step = 0
        else
          daily_step = JSON.parse(response.body)["bucket"][0]["dataset"][0]["point"][0]["value"][0]["intVal"]
        end
        if @user.steps.where( date: date_to_check) != [] 
          today = @user.steps.where( date: date_to_check).first
          today.nb_steps = daily_step
          today.save!
        else
          Step.create!(user: @user, nb_steps: FitnessApi.new(@user, @user.token).get_daily_step, date: date_to_check)
        end
      else
        daily_step = 0
      end
      date_to_check = date_to_check.yesterday
      response = nil
    end
  end

  def access_token?
    fitness = Google::Apis::FitnessV1::FitnessService.new
    fitness.authorization =  @access_token

    aggregate_by = Google::Apis::FitnessV1::AggregateBy.new
    aggregate_by.data_type_name = 'com.google.step_count.delta'
    aggregate_by.data_source_id = 'derived:com.google.step_count.delta:com.google.android.gms:estimated_steps'

    bucket_by_time = Google::Apis::FitnessV1::BucketByTime.new
    bucket_by_time.duration_millis = 86400000

    aggregate_request = Google::Apis::FitnessV1::AggregateRequest.new
    aggregate_request.aggregate_by = [aggregate_by]
    aggregate_request.bucket_by_time = bucket_by_time
    aggregate_request.start_time_millis = (Time.new(Time.now.year, Time.now.month, Time.now.day, 0, 0, 0).to_f * 1000).to_i
    aggregate_request.end_time_millis = (Time.new(Time.now.year, Time.now.month, Time.now.day, 23, 59, 0).to_f * 1000).to_i

    # daily_step = fitness.aggregate_dataset('me', aggregate_request)
    # raise
    
    response = HTTParty.post("https://www.googleapis.com/fitness/v1/users/me/dataset:aggregate",
              :headers => {'Content-Type' => 'application/json', 'Authorization' => "Bearer #{@access_token}"},
              :body => aggregate_request.to_json
    )

    if JSON.parse(response.body)["bucket"].nil? || JSON.parse(response.body)["bucket"][0]["dataset"][0]["point"] == [] 
      return false
    else
      return true
    end
    
  end
end
