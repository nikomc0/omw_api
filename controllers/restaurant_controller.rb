require 'sinatra/cross_origin'
require 'json'

class RestaurantsController < Sinatra::Base
	configure do
	  enable :cross_origin
	end

	before do
		content_type :json
  if request.request_method == 'OPTIONS'
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "DELETE"
    halt 200
  end
	  response.headers['Access-Control-Allow-Origin'] = '*'
	end

	get '/restaurants' do 
		
		@restaurants = Restaurant.all.to_json
	end

	get '/locations' do
		@locations = Restaurant.pluck(:location)
		@locations.uniq.to_json
	end

	get '/restaurants/:location' do
		@restaurant = Restaurant.where(location: params[:location])
		@restaurant.to_json
	end 

	post '/restaurants' do
		@restaurant = Restaurant.new
		@restaurant.location = params[:location].split(" ").map{ |x| x.capitalize }.join(" ")
		@restaurant.name = params[:name].split(" ").map{ |x| x.capitalize }.join(" ")

		if Restaurant.exists?(name: @restaurant.name, location: @restaurant.location)
			@exists = {
				message: "Restaurant already exists"
			}
			@exists.to_json
		else
			if @restaurant.save
				@restaurant.to_json
			else
				"no_data!"
			end
		end
	end

	delete '/restaurants/' do
		@restaurant = Restaurant.find_by_id(params[:id])
		if !@restaurant
			@result = {
				message: "Sorry restaurant doesn't exist"
			}.to_json
		else
			@restaurant.destroy
			@result = {
				message: "#{@restaurant.name}Has been deleted"
			}.to_json
		end
	end
end
