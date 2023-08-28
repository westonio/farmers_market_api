require 'rails_helper'

RSpec.describe 'Markets API' do
  before(:each) do
    markets = create_list(:market, 3)
    
    vendor_ids = create_list(:vendor, 10).pluck(:id)

   markets.each do |market|
      ids = vendor_ids.sample(4)
      MarketVendor.create!(market_id: market.id, vendor_id: ids[0])
      MarketVendor.create!(market_id: market.id, vendor_id: ids[1])
      MarketVendor.create!(market_id: market.id, vendor_id: ids[2])
      MarketVendor.create!(market_id: market.id, vendor_id: ids[3])
    end

  end

  it 'sends a list of Markets' do
    get '/api/v0/markets'
    
    expect(response).to be_successful
    
    markets = JSON.parse(response.body, symbolize_names: true)
    
    expect(markets.size).to eq(3)

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

  it 'also sends a markets count of vendors' do
    get '/api/v0/markets'

    expect(response).to be_successful

    markets = JSON.parse(response.body, symbolize_names: true)

    markets.each do |market|
      expect(market).to have_key(:vendor_count)
      expect(market[:vendor_count]).to be_an(Integer)
      expect(market[:vendor_count]).to eq(4)
    end
  end
end