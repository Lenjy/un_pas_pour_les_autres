class FriendRequestsController < ApplicationController
  skip_before_request :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    @friend_request = FriendRequest.new
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

private 

  def friend_request_params
    params.require(:friend_request).permit(:asker_id, :receiver_id, :status) 
  end

  def find_friend_request
    @friend_request = FriendRequest.find(params[:id])
    @authorize @friend_request
  end 

end
