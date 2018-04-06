require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/cross_origin'
require './config/database'
require_relative './models/restaurant'
require_relative './models/reservation'
require_relative './models/user'
require 'json'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/omw')

configure do
  enable :cross_origin
end

before do
  response.headers['Access-Control-Allow-Origin'] = '*'
end
  
get '/' do
	'Welcome to On My Waitlist'
end
