class NearestAtmService

  def get_atms(lat, lon)
    get_url("/search/2/nearbySearch/.json?lat=#{lat}&lon=#{lon}&limit=20&radius=10000&categorySet=7397")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.tomtom.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials.tomtom[:key]
    end
  end
end