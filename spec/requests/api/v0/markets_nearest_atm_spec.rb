require 'rails_helper'

RSpec.describe 'Find Nearby ATMS API' do
  describe 'GET /api/v0/markets/:id/nearest_atms' do
    before(:each) do
      @market = create(:market, city: "Denver", state: "Colorado", lat: "39.728944", lon: "-104.940809")
    end

    it 'returns the nearest atms', :vcr do
      get "/api/v0/markets/#{@market.id}/nearest_atms"

      expect(response).to be_successful

      atms = JSON.parse(response.body, symbolize_names: true)

      expect(atms).to have_key(:data)
      expect(atms[:data]).to be_an(Array)
      expect(atms[:data].count).to eq(20)

      atm = atms[:data].first[:attributes]

      expect(atm).to have_key(:name)
      expect(atm[:name]).to be_a(String)
      
      expect(atm).to have_key(:address)
      expect(atm[:address]).to be_a(String)

      expect(atm).to have_key(:distance)
      expect(atm[:distance]).to be_a(Float)

      expect(atm).to have_key(:lat)
      expect(atm[:lat]).to be_a(Float)

      expect(atm).to have_key(:lon)
      expect(atm[:lon]).to be_a(Float)
    end

    it 'returns the nearest atms in order of closest to furthest', :vcr do
      get "/api/v0/markets/#{@market.id}/nearest_atms"

      expect(response).to be_successful

      atms = JSON.parse(response.body, symbolize_names: true)

      atm1 = atms[:data].first[:attributes]
      atm2 = atms[:data][1][:attributes]
      atm3 = atms[:data][2][:attributes]
      atm4 = atms[:data][3][:attributes]
      atm5 = atms[:data][4][:attributes]

      expect(atm1[:distance]).to be < atm2[:distance]
      expect(atm2[:distance]).to be < atm3[:distance]
      expect(atm3[:distance]).to be < atm4[:distance]
      expect(atm4[:distance]).to be < atm5[:distance]
    end

    it 'returns the error if market ID is invalid' do
      id = 123123123123123
      get "/api/v0/markets/#{id}/nearest_atms"

      expect(response.status).to eq(404)

      not_found = JSON.parse(response.body, symbolize_names: true)

      expect(not_found).to have_key(:errors)
      expect(not_found[:errors]).to be_an(Array)

      expect(not_found[:errors].first).to have_key(:details)
      expect(not_found[:errors].first[:details]).to be_a(String)
      expect(not_found[:errors].first[:details]).to eq("Couldn't find Market with 'id'=123123123123123")
    end
  end
end