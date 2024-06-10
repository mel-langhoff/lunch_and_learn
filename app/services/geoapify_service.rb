class GeoapifyService

  def self.get_coordinates(country)
    response = get_url("v1/geocode/search", { text: country } )
    data = response[:features].first 
    coordinates = { lat: data[:properties][:lat], lon: data[:properties][:lon] }
  
    coordinates
  end

  def self.get_tourist_sites(coordinates)
    # The circle filter is used to define a circular geographic area for the search. The format for the circle filter is:
    # circle:<longitude>,<latitude>,<radius in m>
    lat = coordinates[:lat]
    lon = coordinates[:lon]

    response = get_url("v2/places", { type: "tourism", bias: "proximity:#{lon},#{lat}", limit: 10 })
    response[:features].map do |attribute|
      {
        name: attribute[:properties][:name],
        address: attribute[:properties][:formatted],
        place_id: attribute[:properties][:place_id]
      }
    end
  end

  private

  def self.conn
    Faraday.new(url: 'https://api.geoapify.com/') do |faraday|
      faraday.params[:apiKey] = Rails.application.credentials.geoapify[:api_key]
      # faraday.params[:page] = "1"
    end
  end

  def self.get_url(url, params = {})
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end
end