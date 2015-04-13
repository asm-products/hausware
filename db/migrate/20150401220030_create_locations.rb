class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :permalink, index: true
      t.references :org, index: true, foreign_key: true
      t.string :phone
      t.string :email
      t.string :timezone
      t.decimal :latitude, precision: 9, scale: 6, index: true
      t.decimal :longitude, precision: 9, scale: 6, index: true
      t.string :street_address1
      t.string :street_address2
      t.string :city, index: true
      t.string :state_province_region, index: true
      t.string :zip_postal_code
      t.string :country_code, index: true
      t.integer :sunday_opening, index: true
      t.integer :sunday_closing, index: true
      t.integer :monday_opening, index: true
      t.integer :monday_closing, index: true
      t.integer :tuesday_opening, index: true
      t.integer :tuesday_closing, index: true
      t.integer :wednesday_opening, index: true
      t.integer :wednesday_closing, index: true
      t.integer :thursday_opening, index: true
      t.integer :thursday_closing, index: true
      t.integer :friday_opening, index: true
      t.integer :friday_closing, index: true
      t.integer :saturday_opening, index: true
      t.integer :saturday_closing, index: true

      t.timestamps null: false
    end
  end
end
