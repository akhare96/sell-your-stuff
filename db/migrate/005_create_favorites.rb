class CreateFavorites < ActiveRecord::Migration[5.2]
    def change
        create_table :favorites do |t|
        t.integer :user_id
        t.integer :post_id
  
        t.timestamps null: false
        end
        #user can like a certain post only 1x - DB level validation
        add_index :favorites, [:user_id, post_id], unique: true
    end
end