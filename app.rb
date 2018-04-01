require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/cross_origin'
require './config/database'
require_relative './models/restaurant'
require_relative './models/reservation'
require 'json'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/omw')

get '/' do
	'Welcome to On My Waitlist'
end

put '/restaurants/:id' do
	@restaurant = Restaurant.find_by_id(params[:id])
	puts @restaurant.waitlist == false
end

