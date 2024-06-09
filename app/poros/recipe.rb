class Recipe
  attr_reader :id, :type, :title, :url, :image

  def initialize(attributes)
    @id = nil
    @type = "recipe"
    @title = attributes[:recipe][:label]
    @url = attributes[:recipe][:url]
    @image = attributes[:recipe][:image]
  end
end