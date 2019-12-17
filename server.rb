require 'sinatra'
require 'sinatra/reloader'

require 'pry'
require 'csv'
require_relative 'app/models/restaurant.rb'

set :bind,'0.0.0.0'  # bind to all interfaces, http://www.sinatrarb.com/configuration.html

get "/" do
  redirect "/restaurants"
end

# INDEX - version 1
# get "/restaurants" do
#   @restaurants = CSV.readlines('restaurant.csv', headers: true)
#
#   erb :index
# end

# INDEX - version 2
# get "/restaurants" do
#   @restaurant_objects = []
#
#   CSV.foreach('restaurants.csv', headers: true) do |row|
#     @restaurant_objects << row.to_hash
#   end
#
#   erb :index
# end

# INDEX - version 3
get "/restaurants" do
  @restaurant_objects = []

  CSV.foreach('restaurants.csv', headers: true) do |row|
    new_restaurant = Restaurant.new(
      row["id"],
      row["name"],
      row["address"],
      row["description"],
      row["url"],
      row["image"],
    )

    @restaurant_objects << new_restaurant
  end

  erb :index
end

get "/restaurants/new" do
  erb :new
end

def retrieve_restaurant_objects
  restaurant_objects = []
  CSV.foreach('restaurants.csv', headers: true) do |row|
    new_restaurant = Restaurant.new(
      row["id"],
      row["name"],
      row["address"],
      row["description"],
      row["url"],
      row["image"],
    )

    restaurant_objects << new_restaurant
  end
  restaurant_objects
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
    csv_file << [id, name, address, description, url, image]
  end

  # redirect "/restaurants"
  redirect "/restaurants/#{id}"
end

# SHOW - version 1
get "/restaurants/:id" do
  id = params["id"]

  restaurant_objects = []

  CSV.foreach('restaurants.csv', headers: true) do |row|
    new_restaurant = Restaurant.new(
      row["id"],
      row["name"],
      row["address"],
      row["description"],
      row["url"],
      row["image"],
    )

    restaurant_objects << new_restaurant
  end

  restaurant_objects.each do |restaurant|
    if restaurant.id == id
      @restaurant = restaurant
    end
  end

  erb :show
end

# SHOW - version 2
# get "/restaurants/:id" do
#   id = params["id"]
#
#   CSV.foreach('restaurants.csv', headers: true) do |row|
#     if row["id"] == id
#       @restaurant = Restaurant.new(
#         row["id"],
#         row["name"],
#         row["address"],
#         row["description"],
#         row["url"],
#         row["image"],
#       )
#     end
#   end
#
#   erb :show
# end
