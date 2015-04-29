class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.references :location, index: true, foreign_key: true
      t.datetime :fulfilled_at
      t.datetime :delivered_at
      t.string :name
      t.string :email
      t.string :phone
      t.string :zipcode
      t.string :confirmation
      t.integer :subtotal_in_cents
      t.integer :tax_in_cents
      t.integer :total_in_cents
      t.string :chargeid
      t.datetime :canceled_at

      t.timestamps null: false
    end
  end
end
