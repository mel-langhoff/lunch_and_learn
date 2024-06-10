class YoutubeService

  def self.get_video(country)
    response = get_url("?q=#{country}")
    parse_response(response)
  end

  private

  def self.parse_response(response)
    if response.key?(:error)
      error_message = response[:error][:message]
      raise StandardError, "YouTube API error: #{error_message}"
    else
      items = response[:items] || []
      items.map do |item|
        {
          title: item[:snippet][:title],
          youtube_video_id: item[:id][:videoId]
        }
      end
    end
  end

  def self.conn
    Faraday.new(url: 'https://www.googleapis.com/youtube/v3/search/') do |faraday|
      faraday.params[:key] = Rails.application.credentials.youtube[:api_key]
      faraday.params[:channelId] = "UCluQ5yInbeAkkeCndNnUhpw"
      faraday.params[:part] = "snippet"
      faraday.params[:maxResults] = "1"
    end
  end

  def self.get_url(url, params = {})
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end
end