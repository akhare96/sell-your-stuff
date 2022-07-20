class Post < ActiveRecord::Base
    belongs_to :user
    belongs_to :location
    has_many :favorites
    has_many :post_categories
    has_many :categories, through: :post_categories
    validates :name, :price, :description, :condition, :quantity, presence: true #:show_phone, :phone_calls, :phone_texts, :show_email
    accepts_nested_attributes_for :location

    def self.conditions
        condition_types = ["new", "like new", "great", "good", "fair"]
    end
   
end