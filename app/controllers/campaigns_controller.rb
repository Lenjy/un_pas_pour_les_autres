class CampaignsController < ApplicationController
  before_action :find_campaign, only: [:show, :edit, :update, :destroy]
  before_action :authorize_campaign

  def show
  end

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new(campaign_params)
    if @campaign.save
      redirect_to campaign_path(@campaign)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @campaign.update(campaign_params)
      redirect_to campaign_path(@campaign)
    else
      render :edit
    end
  end

  def destroy
    @campaign.destroy
    redirect_to campaign_path(@campaign)
  end

  private

  def campaign_params
    params.require(:campaign).permit(:step_convension, :max_contribution, :charity_event_id, :enterprise_id)
  end

  def find_campaign
    @campaign = Campaign.find(params[:id])
  end

  def authorize_campaign
    authorize @campaign
  end

end
