class Restaurant
  attr_reader :name
  attr_reader :description
  attr_reader :image

  def initialize(id, name, address, description, url, image)
    @id = id
    @name = name
    @address = address
    @description = description
    @url = url
    @image = image
  end
end
