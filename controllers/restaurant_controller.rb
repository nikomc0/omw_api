require 'sinatra/cross_origin'

class RestaurantsController < Sinatra::Base
	configure do
	  enable :cross_origin
	end

	before do
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

	get '/reservations/:id' do
	  @restaurant = Restaurant.find_by_id(params[:id])
 		@restaurant.reservations.to_json
	end

	post '/restaurants' do
		@restaurant = Restaurant.new
		@restaurant.location = params[:location]
		@restaurant.name = params[:name]

		if @restaurant.save
			@restaurant.to_json
		else
			"no_data!"
		end
	end

	post '/restaurants/:id' do
		@restaurant = Restaurant.find_by_id(params[:id])
		@reservation = @restaurant.reservations.new
		@reservation.name = params[:name]

		if Reservation.exists?(name: @reservation.name)
			@exists = {
				message: "Reservation already exits"
			}

			@exists.to_json

		else
			@reservation.save
			@reservation.to_json
		end
	end

	# put '/restaurants/:id' do
	# 	@restaurant = Restaurant.find_by_id(params[:id])
	# 	puts @restaurant.waitlist == false
	# end

	delete '/reservations/:restaurantID/:id' do
		@restaurant = Restaurant.find_by_id(params[:restaurantID])
		@reservation = @restaurant.reservations.find_by_id(params[:id])
		
		if !@reservation
			"no_data!"
		else
			@reservation.destroy
		end
		"deleted" + @reservation.to_json
	end
end
