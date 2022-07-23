class Favorite < ActiveRecord::Base
    belongs_to :user
    belongs_to :post
    #model layer validation that user_id is unique as long as we have the same post_id
    validates :user_id, uniqueness: {scope: :post_id}
end