class CharityEventsController < ApplicationController
  def show
    @charity_event = CharityEvent.find(params[:id])
  end
end
