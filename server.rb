require 'sinatra'
require 'sinatra/reloader'

require 'pry'
require 'csv'
require_relative 'app/models/restaurant.rb'

set :bind,'0.0.0.0'  # bind to all interfaces, http://www.sinatrarb.com/configuration.html

get "/" do
  redirect "/restaurants"
end

# version 1
# get "/restaurants" do
#   @restaurants = CSV.readlines("restaurants.csv", headers: true)
#
#   erb :index
# end

# version 2
# get "/restaurants" do
#   @restaurants = []
#
#   CSV.foreach("restaurants.csv", headers: true) do |row|
#     @restaurants << row.to_hash
#   end
#
#
#   erb :index
# end

def retrieve_restaurant_objects
  restaurant_objects = []
  CSV.foreach("restaurants.csv", headers: true) do |row|
    new_restaurant = Restaurant.new(
      row["id"],
      row["name"],
      row["address"],
      row["description"],
      row["url"],
      row["image"]
    )
    restaurant_objects << new_restaurant
  end
  restaurant_objects
end



# version 3
get "/restaurants" do
  @restaurants = []

  CSV.foreach("restaurants.csv", headers: true) do |row|
    new_restaurant = Restaurant.new(
      row["id"],
      row["name"],
      row["address"],
      row["description"],
      row["url"],
      row["image"]
    )
    @restaurants << new_restaurant
  end

  erb :index
end

get "/restaurants/new" do

  erb :new
end

post "/restaurants" do
  name = params["name"]
  address = params["address"]
  description = params["description"]
  url = params["url"]
  image = params["image"]

  last_restaurant_id = retrieve_restaurant_objects.last.id.to_i
  id = last_restaurant_id + 1

  CSV.open("restaurants.csv", "a") do |csv_file|
    csv_file << [name, address, description, url, image]
  end

  redirect "/restaurants"
end

get "/restaurants/:id" do
  id = params["id"]

  restaurant_objects = retrieve_restaurant_objects
  # restaurant_objects = Restaurant.retrieve_restaurant_objects

  restaurant_objects.each do |restaurant|
    if restaurant.id == id
      @restaurant = restaurant
    end
  end

  erb :show
end










# fff
