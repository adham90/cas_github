class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :username, null:false
      t.string :email, null: false
      t.string :avatar_url
      t.string :uid, null: false
      t.timestamps, null: false
    end
  end
end