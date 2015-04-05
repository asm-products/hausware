class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :space, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :email, index: true
      t.string :phone
      t.string :zipcode
      t.datetime :starts_at, index: true
      t.datetime :ends_at, index: true
      t.string :chargeid, index: true

      t.timestamps null: false
    end
    add_index :reservations, [:space_id, :starts_at, :ends_at]
  end
end
