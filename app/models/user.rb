class User < ActiveRecord::Base
    has_secure_password
    has_many :posts
    has_many :categories, through: :posts
    has_many :favorites
    validates :username, uniqueness: { case_sensitive: false }
    validates :username, presence: true
end