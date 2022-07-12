class CreatePosts < ActiveRecord::Migration[5.2]
    def change
        create_table :posts do |t|
        t.string :product_details
        t.boolean :show_phone
        t.boolean :phone_calls
        t.boolean :phone_texts
        t.boolean :show_email

        t.timestamps null: false
        end
    end
end