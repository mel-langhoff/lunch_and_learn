class RecipeService

  def self.get_recipes_by_country(country)
    response = get_url("api/recipes/v2", { q: country, type: "public" } )
    response[:hits].map do |hit|
      recipe = hit[:recipe]
        {
          label: recipe[:label],
          url: recipe[:url],
          image: recipe[:image],
          country: country
        }
    end
  end

  private

  def self.conn
    Faraday.new(url: 'https://api.edamam.com/') do |faraday|
      faraday.params[:app_id] = Rails.application.credentials.edamam_id[:key]
      faraday.params[:app_key] = Rails.application.credentials.edamam[:api_key]
      faraday.headers['Content-Type'] = 'application/json'
      faraday.headers['Accept-Language'] = 'en' 
    end
  end

  def self.get_url(url, params = {})
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end
end