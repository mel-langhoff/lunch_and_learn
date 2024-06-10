class PexelService

  def get_images(country)
    get_url("?query=#{country}")
  end

  private

  def conn
    Faraday.new(url: 'https://api.pexels.com/v1/search/') do |faraday|
      faraday.headers["Authorization"] = Rails.application.credentials.pexel[:api_key]
      faraday.params[:page] = "1"
      faraday.params[:per_page] = "10"
    end
  end

  def get_url(url, params = {})
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end
end