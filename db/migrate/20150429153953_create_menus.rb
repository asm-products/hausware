class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.references :location, index: true, foreign_key: true
      t.string :name
      t.string :permalink
      t.integer :position
      t.integer :sunday_starting
      t.integer :sunday_ending
      t.integer :monday_starting
      t.integer :monday_ending
      t.integer :tuesday_starting
      t.integer :tuesday_ending
      t.integer :wednesday_starting
      t.integer :wednesday_ending
      t.integer :thursday_starting
      t.integer :thursday_ending
      t.integer :friday_starting
      t.integer :friday_ending
      t.integer :saturday_starting
      t.integer :saturday_ending

      t.timestamps null: false
    end
  end
end
