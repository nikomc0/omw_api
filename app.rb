require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/cross_origin'
require './config/database'
require_relative './models/restaurant'
require_relative './models/reservation'
require 'json'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/omw')

<<<<<<< HEAD
configure do
  enable :cross_origin
end

post '/restaurants' do
	@restaurant = Restaurants.new
	@restaurant.location = params[:location]
	@restaurant.name = params[:name]

	if @restaurant.save
		@restaurant.to_json
	else
		no_data!
	end
end

=======
>>>>>>> users
get '/' do
	'Welcome to On My Waitlist'
end

put '/restaurants/:id' do
	@restaurant = Restaurant.find_by_id(params[:id])
	puts @restaurant.waitlist == false
end

