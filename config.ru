require './app'

register Sinatra::CrossOrigin
enable :cross_origin

run Sinatra::Application
