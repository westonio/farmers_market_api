require 'rails_helper'

RSpec.describe 'Markets API' do
  it 'sends a list of Markets' do
    create_list(:market, 5)
    
    get '/api/v0/markets'

    expect(response).to be_successful

    markets = JSON.parse(response.body, symbolize_names: true)
    
    expect(markets.size).to eq(5)

    markets.each do |market|
      expect(market).to have_key(:id)
      expect(market[:id]).to be_an(Integer)

      expect(market).to have_key(:name)
      expect(market[:name]).to be_a(String)
      
      expect(market).to have_key(:street)
      expect(market[:street]).to be_a(String)
      
      expect(market).to have_key(:city)
      expect(market[:city]).to be_a(String)
      
      expect(market).to have_key(:county)
      expect(market[:county]).to be_a(String)
      
      expect(market).to have_key(:state)
      expect(market[:state]).to be_a(String)
      
      expect(market).to have_key(:zip)
      expect(market[:zip]).to be_a(String)
      
      expect(market).to have_key(:lat)
      expect(market[:lat]).to be_a(String)
      
      expect(market).to have_key(:lon)
      expect(market[:lon]).to be_a(String)
    end
  end
end