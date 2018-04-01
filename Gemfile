source 'http://rubygems.org'
 
gem 'sinatra'
gem 'activerecord'
gem 'sinatra-activerecord' # excellent gem that ports ActiveRecord for Sinatra
gem 'rake'
gem "sinatra-cross_origin", "~> 0.3.1"
 
group :development, :test do
  gem 'sqlite3'
end
 
group :production do
  gem 'pg', '0.20' # this gem is required to use postgres on Heroku
end