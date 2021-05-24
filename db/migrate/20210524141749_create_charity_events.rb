class CreateCharityEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :charity_events do |t|
      t.string :title
      t.string :charity_name
      t.date :date_beginning
      t.date :date_ending
      t.integer :total_donation

      t.timestamps
    end
  end
end
