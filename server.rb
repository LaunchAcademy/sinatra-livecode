require 'sinatra'
require 'sinatra/reloader'

require 'pry'
require 'csv'
require_relative 'app/models/restaurant.rb'

set :bind,'0.0.0.0'  # bind to all interfaces, http://www.sinatrarb.com/configuration.html

def create_restaurant_array
  restaurants = []
  CSV.foreach('restaurants.csv', headers: true) do |row|
    # create a new Restaurant object and put it in array
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

get "/" do
  redirect to "/restaurants"
end

get "/restaurants" do
  @restaurants = create_restaurant_array

  erb :index
end

get "/restaurants/new" do
  erb :new
end

get "/restaurants/:id" do
  selected_restaurant_id = params[:id]
  restaurants = create_restaurant_array
  @restaurant = restaurants.select {|restaurant| restaurant.id == selected_restaurant_id }[0]

  # restaurants.each do |restaurant|
  #   if restaurant.id == selected_restaurant_id
  #     @restaurant = restaurant
  #   end
  # end

  erb :show
end

post '/restaurants' do
  new_restaurant_id = create_restaurant_array.length + 1
  CSV.open('restaurants.csv', 'a') do |csv|
    csv << [
      new_restaurant_id,
      params["name"],
      params["address"],
      params["description"],
      params["url"],
      params["image"]
    ]
  end

  redirect to "/restaurants/#{new_restaurant_id}"
end

# get "*" do
#   redirect to "/restaurants"
# end
