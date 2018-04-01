require './app'
require_relative './controllers/restaurant_controller'

use RestaurantsController

run Sinatra::Application
