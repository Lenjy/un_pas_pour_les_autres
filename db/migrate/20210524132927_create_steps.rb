class CreateSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :steps do |t|
      t.date :date
      t.integer :nb_steps
      t.integer :week
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
