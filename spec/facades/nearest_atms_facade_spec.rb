require 'rails_helper'

RSpec.describe NearestAtmsFacade do
  describe 'Instance Methods', :vcr do
    before(:each) do
      @facade = NearestAtmsFacade.new
      @lat = "39.7289449"
      @lon = "-104.940809" 
    end

    it 'exists' do
      expect(@facade).to be_a(NearestAtmsFacade)  
    end

    it 'returns nearest atms and create ATM objects' do
      atms = @facade.nearest_atms(@lat, @lon)

      expect(atms).to be_an(Array)
      expect(atms.size).to eq(20)
      atms.each do |atm|
        expect(atm).to be_an(Atm)
      end
    end
  end
end