require 'sinatra'
require 'sinatra/reloader'

require 'pry'
require 'csv'
require_relative 'app/models/restaurant.rb'

set :bind,'0.0.0.0'  # bind to all interfaces, http://www.sinatrarb.com/configuration.html

def get_restaurants
  restaurants = []

  CSV.foreach('restaurants.csv', headers: true) do |row|

    restaurants << Restaurant.new(
      row["id"],
      row["name"],
      row["address"],
      row["description"],
      row["url"],
      row["image"]
    )
  end
  restaurants
end

get '/restaurants' do
  @restaurants = get_restaurants
  erb :index
end

get "/restaurants/new" do
  erb :new
end

get '/restaurants/:id' do

  CSV.foreach('restaurants.csv', headers: true) do |row|

    if params["id"] == row["id"]
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
  @restaurants = get_restaurants
  id = @restaurants.last.id.to_i + 1

    CSV.open('restaurants.csv', 'a') do |csv|
      csv << [
        id,
        params["name"],
        params["address"],
        params["description"],
        params["url"],
        params["image"]
      ]
    end

# redirect "/restaurants"
redirect "/restaurants/#{id}"
end
