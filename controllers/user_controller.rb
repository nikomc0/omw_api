require 'sinatra/cross_origin'

class UsersController < Sinatra::Base
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

	get '/users' do 
		@users = User.all.to_json
	end

	post '/users' do
		@user = User.new
		@user.first_name = params[:first_name]
		@user.last_name = params[:last_name]
		@user.phone_number = params[:phone_number]

		if User.exists?(phone_number: @user.phone_number)
			@user = User.find_by(phone_number: @user.phone_number)
			@user.to_json
		else
			if @user.save
				@user.to_json
			else
				"User not created."
			end
		end
	end

	get '/users/:phone_number' do
		@user = User.find_by(phone_number: (params[:phone_number]))
		@user.to_json
	end

	delete '/users/:id' do
		@user = User.find_by_id(params[:id])

		if !@user 
			"No User found."
		else
			@user.destroy
			@user.to_json
			"User #{@user.first_name} #{@user.last_name} has been deleted."
		end
	end
end