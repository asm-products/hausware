class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.references :location, index: true, foreign_key: true
      t.string :name
      t.string :permalink, index: true
      t.integer :standard_hourly_price_in_cents, index: true
      t.string :picurl
      t.integer :reservable_quantity, index: true
      t.text :description
      t.integer :max_days_in_advance_reservable

      t.timestamps null: false
    end
    add_index :spaces, [:location_id, :permalink]
  end
end
