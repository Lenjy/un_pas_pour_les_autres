class CampaignsController < ApplicationController
  before_action :find_campaign, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new(campaign_params)
    @campaign.save
    redirect_to campaign_path(@campaign)
  end

  def edit

  end

  def update
    @campaign.update(campaign_params)
    redirect_to campaign_path(@campaign)
  end

  def destroy
    @campaign.destroy
    redirect_to campaign_path(@campaign)
  end


  private

  def campaign_params
    params.require(:campaign).permit(:step_convension, :max_contribution, :charity_event)
  end

  def find_campaign
    @campaign = Campaign.find(params[:id])
  end

end
