require 'json'
require 'rack/test'
require_relative '../../controllers/reservation_controller'
require_relative '../spec_helper'

RSpec.describe 'Reservations Controller', type: :controller do
	include Rack::Test::Methods
	
	def app
		ReservationsController.new
	end 

	let(:restaurant) { Restaurant.find_by_id(1) }
	let(:user) { User.new(first_name: "Jasmine", last_name: "St James", phone_number: "019829328") }
	
	before do 
		get '/reservations/?id=' + restaurant.id.to_s	
	end

	it 'returns http success' do
		expect(last_response.status).to eq(200)
	end

	it 'shows restaurants reservations' do			
		parsed = JSON.parse(last_response.body)
	end

	it "creates a reservation for current user" do
		expect{ post '/reservations/?id=' + restaurant.id.to_s + '&first_name=' + user.first_name + '&last_name=' + user.last_name + '&phone_number=' + user.phone_number }.to change{ Reservation.count }.by(1)
	end

	it "notifies of existing reservations by current user" do 
		post '/reservations/?id=' + restaurant.id.to_s + '&first_name=' + user.first_name + '&last_name=' + user.last_name + '&phone_number=' + user.phone_number
		post '/reservations/?id=' + restaurant.id.to_s + '&first_name=' + user.first_name + '&last_name=' + user.last_name + '&phone_number=' + user.phone_number

		parsed = JSON.parse(last_response.body)
		expect(parsed).to include('message' => 'Reservation already exists.')
	end

	it 'deletes a current reservation' do
		user_for_deletion = {
			phone_number: "019829328"
		}
		current_user = Reservation.find_by(phone_number: user_for_deletion[:phone_number])
		delete '/reservations/' + restaurant.id.to_s + '/?id=' + current_user.id.to_s
		
		parsed = JSON.parse(last_response.body)
		expect(parsed["id"]).to eq(current_user[:id])
		expect(parsed["phone_number"]).to eq(current_user[:phone_number])
	end
end
