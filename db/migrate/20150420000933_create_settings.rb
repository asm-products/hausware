class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.references :org, index: true, foreign_key: true
      t.string :stripe_publishable_key
      t.string :stripe_secret_key_encrypted
      t.string :salt
      t.text :default_location_spaces

      t.timestamps null: false
    end
  end
end
