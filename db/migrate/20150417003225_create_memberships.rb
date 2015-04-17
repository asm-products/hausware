class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :org, index: true, foreign_key: true
      t.references :location, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :privileges

      t.timestamps null: false
    end

    add_index :memberships, [:org_id, :user_id, :privileges]
    add_index :memberships, [:location_id, :user_id, :privileges]
  end
end
