require 'json'
require 'rack/test'
require_relative '../../controllers/restaurant_controller'
require_relative '../spec_helper'

RSpec.describe 'Restaurants Controller', type: :controller do
	include Rack::Test::Methods
	
	def app
		RestaurantsController.new
	end 
	
	let(:restaurant) { Restaurant.find_by_id(1) }

	describe '/restaurants' do
		before do
			get '/restaurants'
		end

		it 'returns http success' do
			expect(last_response.status).to eq(200)
		end

		it 'shows all restaurants' do
			parsed = JSON.parse(last_response.body)
			expect(parsed).not_to be_empty
		end
	end

	describe '/locations' do 
		before do 
			get '/locations'
		end

		it 'returns http success' do 
			expect(last_response.status).to eq(200)
		end

		it 'shows all locations.' do
			parsed = JSON.parse(last_response.body)
			expect(parsed).not_to be_empty
		end
	end

	describe 'Individual restaurant' do
		before do
			location = restaurant.location.split(" ").map{|x| x}.join("%20")
			get '/restaurants/' + location
		end

		it 'returns http sucess' do
			expect(last_response.status).to eq(200)
		end

		it 'displays restaurants by specific location.' do
			parsed = JSON.parse(last_response.body)
			expect(parsed).not_to be_empty
		end
	end

	# describe "Restaurant" do
	# 	it 'creates a new restaurant' do
	# 		my_new_restaurant = {
	# 			name: "Jeromes",
	# 			location: "Odessa"
	# 		}
	# 		post '/restaurants?name=' + my_new_restaurant[:name] + "&location=" + my_new_restaurant[:location]

	# 		expect(last_response.body).not_to be_empty
	# 	end

	# 	it 'deletes a current restaurant' do 
	# 		my_new_restaurant = {
	# 			name: "Jeromes",
	# 			location: "Odessa"
	# 		}
	# 		post '/restaurants?name=' + my_new_restaurant[:name] + "&location=" + my_new_restaurant[:location]
			
	# 		delete '/restaurants/?id=' + my_new_restaurant[:id].to_s

	# 		parsed = JSON.parse(last_response.body)
	# 		expect(parsed).not_to be_empty
	# 	end
	# end

end
