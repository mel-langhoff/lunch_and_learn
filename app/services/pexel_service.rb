class PexelService

  def self.get_images(country)
    get_url("?query=#{country}")
  end

  private

  def self.conn
    Faraday.new(url: 'https://api.pexels.com/v1/search/') do |faraday|
      faraday.headers["Authorization"] = Rails.application.credentials.pexel[:api_key]
      faraday.params[:page] = "1"
      faraday.params[:per_page] = "10"
    end
  end

  def self.get_url(url, params = {})
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end
end