class User < ActiveRecord::Base
	has_one :restaurants
	has_one :reservations
end