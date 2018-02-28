require 'sinatra'
require 'sinatra/activerecord'
require_relative './models/restaurant'
require 'json'

configure :development do
  set :database, {adapter: 'postgresql',  encoding: 'unicode', database: 'omw', pool: 2, username: 'nikomc0', password: ''}
end

before do
  content_type :json
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

get '/' do
	'Welcome to On My Waitlist'
end

get '/restaurants' do 
	@restaurants = Restaurants.all.to_json
end

get '/restaurants/:id' do
  @restaurant = Restaurants.find_by_id(params[:id]).to_json
end


delete '/restaurants/:id' do
	@restaurant = Restaurants.find_by_id(params[:id])

	if !@restaurant
		no_data!
	else
		@restaurant.destroy
	end
	"deleted"
end
