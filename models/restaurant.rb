class Restaurant < ActiveRecord::Base
	has_many :reservations
	scope :sf, -> { where(location: "San Francisco") }
	scope :ny, -> { where(location: "New York") }
end
