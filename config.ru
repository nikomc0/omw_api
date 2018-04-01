require './app'
require_relative './controllers/restaurant_controller'

use RestaurantsController

register Sinatra::CrossOrigin
enable :cross_origin

run Sinatra::Application
