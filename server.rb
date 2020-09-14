require 'sinatra'
require 'sinatra/reloader'

require 'pry'
require 'csv'
# require_relative 'app/models/restaurant.rb'

set :bind,'0.0.0.0'  # bind to all interfaces, http://www.sinatrarb.com/configuration.html

get "/restaurants" do 
  @restaurants = CSV.readlines("restaurants.csv", headers: true)

  erb :index
end

post "/restaurants" do 
  new_name = params[:restaurant_name]

  CSV.open("restaurants.csv", "a") do |csv|
    csv << [new_name]
  end 

  redirect "/restaurants"
end

get "/restaurants/new" do 
  erb :new
end

get "/restaurants/:id" do 
  restaurant_id = params[:id]

  @restaurants_array = CSV.readlines("restaurants.csv", headers: true)

  @restaurants_array.each do |restaurant_hash|
    if restaurant_hash["id"] == restaurant_id
      @restaurant = restaurant_hash
    end
  end

  erb :show
end

