class Restaurant
  attr_accessor :id, :name, :address, :description, :url, :image

  def initialize(id, name, address, description, url, image)
    @id = id
    @name = name
    @address = address
    @description = description
    @url = url
    @image = image
  end

  # def self.retrieve_restaurant_objects #all
  #   restaurant_objects = []
  #   CSV.foreach("../../restaurants.csv", headers: true) do |row|
  #     new_restaurant = Restaurant.new(
  #       row["id"],
  #       row["name"],
  #       row["address"],
  #       row["description"],
  #       row["url"],
  #       row["image"]
  #     )
  #     restaurant_objects << new_restaurant
  #   end
  #   restaurant_objects
  # end

end
