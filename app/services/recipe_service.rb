class RecipeService

  def by_country(country)
    url = "/api/v1/recipes"
    params = {
      type: "public",
      q: country
      }

    get_url(url, params)
  end

  def conn
    Faraday.new(url: 'https://api.edamam.com/') do |faraday|
    end
  end

  def get_url(url, params = {})
    response = conn.get(url) do |request|
      request.params = params
      request.params["app_id"] = Rails.application.credentials.key[:edamam_id]
      request.params["app_key"] = Rails.application.credentials.api_key[:edamam]
    end

    if response.success?
      JSON.parse(response.body, symbolize_names: true)
    else
      # rework this but for now put this basic shit
      { error: "Failed to fetch data." }
    end
  end
end