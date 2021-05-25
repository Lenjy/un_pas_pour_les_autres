class TeamsController < ApplicationController
  before_action :authorize_team

  def show
    @team = Team.find(params[:id])
  end

  private

  def authorize_team
    authorize @team
  end

end
