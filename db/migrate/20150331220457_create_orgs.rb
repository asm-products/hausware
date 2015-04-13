class CreateOrgs < ActiveRecord::Migration
  def change
    create_table :orgs do |t|
      t.string :name
      t.string :permalink, index: true
      t.string :email
      t.string :phone
      t.references :owner, references: :users, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
