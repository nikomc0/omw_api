class RestaurantsController < Sinatra::Base

	get '/restaurants' do 
		@restaurants = Restaurant.all.to_json
	end

	get '/restaurants/:location' do
	  @restaurant = Restaurant.find_by_id(params[:location])
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

		if !@reservation.name
			"no_data!"
		else
			@reservation.save
			@restaurant.reservations.to_json
		end
	end

	delete '/restaurants/:id' do
		@restaurant = Restaurant.find_by_id(params[:id])
		@reservation = @restaurant.reservations.find_by_id(params[:id])
		
		if !@reservation
			"no_data!"
		else
			@reservation.destroy
		end
		"deleted"
	end
end
