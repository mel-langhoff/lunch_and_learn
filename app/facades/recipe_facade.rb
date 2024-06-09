class RecipeFacade

  def by_country(country)
    service = RecipeService.new
    recipe_list = service.by_country
  end
end