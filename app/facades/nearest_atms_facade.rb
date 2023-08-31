class NearestAtmsFacade
  def nearest_atms(lat, lon)
    service = NearestAtmService.new
    json = service.get_atms(lat, lon)
    create_atms(json)
  end

  def create_atms(json)
    json[:results].map do |atm_data|
      Atm.new(atm_data)
    end
  end
end