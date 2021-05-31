class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    # if current_user.steps.where( date: Date.today) != nil 
    #   current_user.steps.where( date: Date.today).nb_steps = FitnessApi.new(current_user, current_user.token).get_daily_step
    #   current_user.steps.where( date: Date.today).save
    # else
    #   Step.create!(user: current_user, nb_steps: FitnessApi.new(current_user, current_user.token).get_daily_step, date: Date.today)
    # end
    @user = User.find(params[:id])
    authorize @user
  end

end
