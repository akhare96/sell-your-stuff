class User < ActiveRecord::Base
    has_secure_password
    has_many :posts
    has_many :categories, through: :posts
    has_many :favorites
    belongs_to :location, class_name: "Location", optional: true # use when associated record doesn't exist and you're trying to save
    validates :username, uniqueness: { case_sensitive: false }
    validates :username, presence: true
    accepts_nested_attributes_for :location, reject_if: :all_blank # does not save location if attributes field blank
end