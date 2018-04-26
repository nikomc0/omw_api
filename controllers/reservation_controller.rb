require 'sinatra/cross_origin'

class ReservationsController < Sinatra::Base
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

	get '/reservations/' do
	  @restaurant = Restaurant.find_by_id(params[:id])
 		@restaurant.reservations.to_json
	end

	post '/reservations/' do
		@restaurant = Restaurant.find_by_id(params[:id])
		@reservation = @restaurant.reservations.new
		@reservation.name = params[:first_name] + ' ' + params[:last_name]
		@reservation.phone_number = params[:phone_number]

		if Reservation.exists?(phone_number: params[:phone_number])
			@exists = {
				message: "Reservation already exists."
			}
			@exists.to_json
		else
			@reservation.save
			@reservation.to_json
		end
	end

	put '/reservations/' do
		@reservation = Reservation.find_by(phone_number: params[:phone_number])
	end 

	delete '/reservations/:restaurantID/' do
		@restaurant = Restaurant.find_by_id(params[:restaurantID])
		@reservation = @restaurant.reservations.find_by_id(params[:id])
		@result
		if !@reservation
			@result = {message: "no_data!"}.to_json
		else
			@reservation.destroy
			@reservation.to_json
		end
	end
end