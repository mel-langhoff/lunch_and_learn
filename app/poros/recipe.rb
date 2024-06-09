class Recipe
  attr_reader :id, :type, :title, :url, :image

  def initialize(attributes)
    @id = nil
    @type = "recipe"
    @title = attributes[:label]
    @url = attributes[:url]
    @image = attributes[:image]
  end
end