require 'sinatra'
require 'sinatra/activerecord'
require './config/database'
require_relative './models/restaurant'
require_relative './models/reservation'
require 'json'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/omw')

post '/restaurants' do
	@restaurant = Restaurant.new
	@restaurant.location = params[:location]
	@restaurant.name = params[:name]

	if @restaurant.save
		@restaurant.to_json
	else
		no_data!
	end
end

get '/' do
	'Welcome to On My Waitlist'
end

get '/restaurants' do 
	@restaurants
end

get '/restaurants/:id' do
  @restaurant = Restaurant.find_by_id(params[:id])
  @restaurant.reservations.to_json
end

put '/restaurants/:id' do
	@restaurant = Restaurant.find_by_id(params[:id])
	puts @restaurant.waitlist == false
end

delete '/restaurants/:id' do
	@restaurant = Restaurant.find_by_id(params[:id])

	if !@restaurant
		no_data!
	else
		@restaurant.destroy
	end
	"deleted"
end
