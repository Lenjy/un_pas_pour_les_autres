class UsersController < ApplicationController
  before_action :authorize_user

  def show
  end

  private

  def authorize_user
    authorize @user
  end
end
