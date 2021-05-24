class CreateCampaigns < ActiveRecord::Migration[6.0]
  def change
    create_table :campaigns do |t|
      t.integer :step_conversion
      t.integer :max_contribution
      t.references :charity_event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
