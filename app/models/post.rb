class Post < ActiveRecord::Base
    belongs_to :user
    belongs_to :location
    has_many :favorites
    has_many :post_categories
    has_many :categories, through: :post_categories
    validates :show_phone, :phone_calls, :phone_texts, :show_email, presence: true
end