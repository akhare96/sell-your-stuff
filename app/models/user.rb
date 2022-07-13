class User < ActiveRecord::Base
    has_secure_password
    has_many :posts
    has_many :categories, through: :posts
    has_many :favorites
    validates :username, presence: true
    validates :username, uniqeness: { case_sensitive: false }
    validates :phone_number length: { is: 10 }
end