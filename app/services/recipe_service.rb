class RecipeService

  def get_recipes_by_country(country)
    get_url("/api/recipes/v2", { q: country, type: "public" } )
  end

  private

  def conn
    Faraday.new(url: 'https://api.edamam.com/') do |faraday|
      faraday.params[:app_id] = Rails.application.credentials.edamam_id[:key]
      faraday.params[:app_key] = Rails.application.credentials.edamam[:api_key]
      faraday.headers['Content-Type'] = 'application/json'
      faraday.headers['Accept-Language'] = 'en' 
    end
  end

  def get_url(url, params = {})
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end
end