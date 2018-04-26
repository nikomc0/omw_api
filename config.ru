require './app'
require_relative './controllers/restaurant_controller'
require_relative './controllers/user_controller'
require_relative './controllers/reservation_controller'

use RestaurantsController
use UsersController
use ReservationsController

run Sinatra::Application
