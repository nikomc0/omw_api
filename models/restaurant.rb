class Restaurant < ActiveRecord::Base
	has_many :reservations
	has_many :users, through: :reservations
	scope :sf, -> { where(location: "San Francisco") }
	scope :ny, -> { where(location: "New York") }
end
