class CharityEventsController < ApplicationController
  def show
    @charity_event = CharityEvent.find(params[:id])
    authorize @charity_event
  end
end
