class AddContentToCharityEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :charity_events, :content, :text
  end
end
