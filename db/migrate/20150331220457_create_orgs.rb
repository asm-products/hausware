class CreateOrgs < ActiveRecord::Migration
  def change
    create_table :orgs do |t|
      t.string :name
      t.string :permalink, index: true
      t.string :email
      t.string :phone
      t.string :url
      t.references :owner, references: :users, index: true

      t.timestamps null: false
    end
    add_foreign_key :orgs, :users, column: :owner_id
  end
end
