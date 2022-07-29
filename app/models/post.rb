class Post < ActiveRecord::Base
    belongs_to :user
    has_many_attached :images
    belongs_to :location
    has_many :favorites
    has_many :post_categories
    has_many :categories, through: :post_categories
    validates :name, :price, :description, :condition, :quantity, presence: true #:show_phone, :phone_calls, :phone_texts, :show_email
    validates :images, attached: true
    accepts_nested_attributes_for :location, reject_if: :all_blank

    def self.conditions
        condition_types = ["new", "like new", "great", "good", "fair"]
    end

    def self.states
        states = CS.states(:us)
        states_array = []
        states.each.collect do |key, value|
            states_array << value
        end
        states_array
    end

    def self.cities
        states = CS.states(:us)
        cities = []
        keys = []
        states.each.collect do |key, value|
            state_key = key.to_s
            cities << CS.cities(state_key, "US")
        end
        cities.reduce(:concat).uniq.sort
    end

    def location_attributes=(location)
        if !(location[:state].empty? && location[:city].empty?)
            self.location = Location.find_or_create_by(state: location[:state], city: location[:city])
            self.location.update(location)
        end
    end

    def self.user_with_location(user = nil)
        includes(:location).where(location: {state: user.location.state, city: user.location.city})
        #returns active record relation object vs array with native ruby code
    end

    def self.high_to_low(user = nil)
        if !user.nil? && !user.location.nil?
            self.user_with_location(user).order("price DESC")
        else
            order("price DESC")
        end
    end
      
    def self.low_to_high(user = nil)
        if !user.nil? && !user.location.nil?
            self.user_with_location(user).order("price ASC")
        else
            order("price ASC")
        end
    end

    def self.categories_filter(current_user = nil, category_id)
        if !current_user.nil? && !current_user.location.nil?
            self.user_with_location(current_user).includes(:categories).where(categories: {id: category_id})
        else
            includes(:categories).where(categories: {id: category_id})
        end
    end

end