require './app'
require_relative './controllers/restaurant_controller'
require_relative './controllers/user_controller'

use RestaurantsController
use UsersController

run Sinatra::Application
