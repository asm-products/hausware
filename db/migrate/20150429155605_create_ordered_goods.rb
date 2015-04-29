class CreateOrderedGoods < ActiveRecord::Migration
  def change
    create_table :ordered_goods do |t|
      t.references :order, index: true, foreign_key: true
      t.references :good, index: true, foreign_key: true
      t.string :name
      t.integer :quantity
      t.integer :subtotal_in_cents
      t.datetime :fulfilled_at
      t.datetime :canceled_at

      t.timestamps null: false
    end
  end
end
