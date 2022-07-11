class User < ActiveRecord::Base
    has_many :posts
    has_many :categories, through: :posts
    has_many :favorites
end