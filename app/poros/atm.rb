class Atm
  attr_reader :id, :name, :distance, :address, :lat, :lon
  
  def initialize(atm_data)
    @id = nil
    @name = atm_data[:poi][:name]
    @distance = atm_data[:dist]
    @address = atm_data[:address][:freeformAddress]
    @lat = atm_data[:position][:lat]
    @lon = atm_data[:position][:lon]
  end
end