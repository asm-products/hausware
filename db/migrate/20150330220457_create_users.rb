class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, index: true
      t.string :username, index: true
      t.string :password_digest
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :phone
      t.string :zipcode
      t.string :angellistid, index: true
      t.string :facebookid, index: true
      t.string :githubid, index: true
      t.string :googleid, index: true
      t.string :linkedinid, index: true
      t.string :twitterid, index: true
      t.string :picurl
      t.boolean :superuser, index: true

      t.timestamps null: false
    end
  end
end
