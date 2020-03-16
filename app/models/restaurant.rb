class Restaurant
  attr_reader :name, :address, :description, :url, :image, :id
  def initialize(id, name, address, description, url, image)
    @id = id
    @name = name
    @address = address
    @description = description
    @url = url
    @image = image
  end
end
