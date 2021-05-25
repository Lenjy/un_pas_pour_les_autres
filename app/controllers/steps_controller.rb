class StepsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :find_steps, only [:show]

  def new
    @user = User.find(params[:user_id])
    @steps = Steps.new
    authorize @step
  end

  def create
    @user = User.find(params[:user_id])
    @step = Step.new(step_params)
    authorize @step
    @step.user = current_user
    if step.save 
      redirect_to dashboard_path
    else 
      render :new
    end 
  end

  def show
    
  end

  private 

  def step_params
      params.require(:step).permit(:user_id, :date, :nb_steps, :week)
  end

  def find_step
    @steps = Step.find(params[:id])
    autthorize @step
  end

end
