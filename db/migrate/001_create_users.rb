class CreateUsers < ActiveRecord::Migration[5.2]
    def change
        create_table :users do |t|
        t.string :username
        t.string :email
        t.string :phone_number
        t.string :password_digest
        t.integer :location_id
  
        t.timestamps null: false
        end
    end
end