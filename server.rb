require 'sinatra'
require 'pry'
require 'csv'
require_relative 'app/restaurant.rb'

set :bind,'0.0.0.0'  # bind to all interfaces, http://www.sinatrarb.com/configuration.html
