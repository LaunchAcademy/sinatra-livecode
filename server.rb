require 'sinatra'
require 'sinatra/reloader'

require 'pry'
require 'csv'
require_relative 'app/models/restaurant.rb'

set :bind,'0.0.0.0'  # bind to all interfaces, http://www.sinatrarb.com/configuration.html

get "/" do
  redirect "/restaurants"
end

def get_restaurants
  restaurants = []
  CSV.foreach('restaurants.csv', headers: true) do |row|
    new_restaurant = Restaurant.new(
      row["id"],
      row["name"],
      row["address"],
      row["description"],
      row["url"],
      row["image"]
    )

    restaurants << new_restaurant
  end
  restaurants
end

get '/restaurants' do
  # @restaurants = CSV.readlines('restaurants.csv', headers: true)

  @restaurants = get_restaurants
  erb :index
end

get "/restaurants/new" do
  erb :new
end

get '/restaurants/:id' do
  id = params["id"]

  CSV.foreach('restaurants.csv', headers: true) do |row|
    if id == row["id"]
      @restaurant = Restaurant.new(
        row["id"],
        row["name"],
        row["address"],
        row["description"],
        row["url"],
        row["image"]
      )
    end
  end
  erb :show
end

post '/restaurants' do
  name = params["name"]
  address = params["address"]
  description = params["description"]
  url = params["url"]
  image = params["image"]

  restaurants = get_restaurants
  id = restaurants.last.id.to_i + 1

  CSV.open('restaurants.csv', 'a') do |csv|
    csv << [
      id,
      name,
      address,
      description,
      url,
      image
    ]
  end
  # redirect "/restaurants"
  redirect "/restaurants/#{id}"
end