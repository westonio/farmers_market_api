require 'rails_helper'

RSpec.describe NearestAtmService do
  describe 'Instance Methods' do
    it 'returns returns up to 20 atm locations', :vcr do
      lat = "39.7289449"
      lon = "-104.940809" 
      atms = NearestAtmService.new.get_atms(lat, lon)

      expect(atms).to be_a(Hash)
      expect(atms[:results]).to be_an(Array)
      expect(atms[:results].count).to eq(20)
    end

    it 'has the needed ATM Data', :vcr do
      lat = "39.7289449"
      lon = "-104.940809"  
      atms = NearestAtmService.new.get_atms(lat, lon)

      atm = atms[:results].first
  
      expect(atm).to have_key(:poi)
      expect(atm[:poi]).to be_a(Hash)
      expect(atm[:poi]).to have_key(:name)
      expect(atm[:poi][:name]).to be_a(String)
      
      expect(atm).to have_key(:position)
      expect(atm[:position]).to be_a(Hash)
      expect(atm[:position]).to have_key(:lat)
      expect(atm[:position][:lat]).to be_a(Float)
      expect(atm[:position]).to have_key(:lon)
      expect(atm[:position][:lon]).to be_a(Float)
      
      expect(atm).to have_key(:address)
      expect(atm[:address]).to be_a(Hash)
      expect(atm[:address]).to have_key(:freeformAddress)
      expect(atm[:address][:freeformAddress]).to be_a(String)
    end
  end
end