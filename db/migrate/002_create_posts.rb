class CreatePosts < ActiveRecord::Migration[5.2]
    def change
        create_table :posts do |t|
        t.string :name
        t.integer :price
        t.string :description
        t.string :make_manufacturer
        t.string :model_number
        t.string :size_dimensions
        t.string :condition
        t.integer :quantity
        t.boolean :show_phone, default: false
        t.boolean :phone_calls, default: false
        t.boolean :phone_texts, default: false
        t.boolean :show_email, default: false
        t.integer :user_id
        t.integer :location_id

        t.timestamps null: false
        end
    end
end