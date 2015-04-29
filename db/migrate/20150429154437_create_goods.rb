class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.references :menu, index: true, foreign_key: true
      t.string :name
      t.string :permalink
      t.integer :price_in_cents
      t.string :picurl
      t.text :description

      t.timestamps null: false
    end
  end
end
