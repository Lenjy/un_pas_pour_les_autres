class AddCampaignToTeams < ActiveRecord::Migration[6.0]
  def change
    add_reference :teams, :campaign, null: false, foreign_key: true
  end
end
