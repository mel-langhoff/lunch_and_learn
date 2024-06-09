class RecipeService

  def get_recipes_by_country(country)
    get_url("api/v1/recipes/type=public&q=#{country}")    
  end

  def conn
    Faraday.new(url: 'https://api.edamam.com/') do |faraday|
      faraday.params[:app_id] = Rails.application.credentials.edamam_id[:key]
      faraday.params[:app_key] = Rails.application.credentials.edamam[:api_key]
    end
  end

  def get_url(url, params = {})
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end