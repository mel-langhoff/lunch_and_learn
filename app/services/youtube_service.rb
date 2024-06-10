class YoutubeService

  def search(country)
    get_url("?q=#{country}")
  end

  private

  def conn
    Faraday.new(url: 'https://www.googleapis.com/youtube/v3/search/') do |faraday|
      faraday.params[:key] = Rails.application.credentials.youtube[:api_key]
      faraday.params[:channelId] = "UCluQ5yInbeAkkeCndNnUhpw"
      faraday.params[:part] = "snippet"
      faraday.params[:maxResults] = "1"
    end
  end

  def get_url(url, params = {})
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end
end