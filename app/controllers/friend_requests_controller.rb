class FriendRequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friend_request = FriendRequest.new(asker_id: current_user.id, receiver_id: params[:user_id])
    @friend_request.save!
    redirect_to dashboard_path
    authorize @friend_request
  end

  def new
    @user = User.find(params[:user_id])
    @friend_request = FriendRequest.new(friend_request_params)
    authorize @friend_request
    if @friend_request.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def show
    
  end
  

  def accept
    find_friend_request
    @friend_request.update(status: :accepted)
    redirect_to dashboard_path
  end

  def decline
    find_friend_request
    @friend_request.update(status: :decline)
    redirect_to dashboard_path
  end

private 

  def friend_request_params
    params.require(:friend_request).permit(:asker_id, :receiver_id, :status) 
  end

  def find_friend_request
    @friend_request = FriendRequest.find(params[:id])
    authorize @friend_request
  end 

end
