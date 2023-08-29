require 'rails_helper'

RSpec.describe 'Market Vendors API' do
  before(:each) do
    @market1 = create(:market)
    @market2 = create(:market)
    
    vendor_ids = create_list(:vendor, 5).pluck(:id)

    @market1.market_vendors.create!(vendor_id: vendor_ids[0])
    @market1.market_vendors.create!(vendor_id: vendor_ids[1])
    @market1.market_vendors.create!(vendor_id: vendor_ids[2])
    @market1.market_vendors.create!(vendor_id: vendor_ids[3])
    @market1.market_vendors.create!(vendor_id: vendor_ids[4])
  end
  
  describe 'GET /markets/:id/vendors' do
    context 'using a valid market ID (happy path)' do
      it 'returns a list of Vendors' do
        get "/api/v0/markets/#{@market1.id}/vendors"

        expect(response).to be_successful

        vendors = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(vendors.count).to eq(5)

        
        vendors.each do |vendor|
          expect(vendor).to have_key(:id)
          expect(vendor[:id]).to be_an(String)
          expect(vendor[:type]).to eq('vendor')

          expect(vendor[:attributes]).to have_key(:name)
          expect(vendor[:attributes][:name]).to be_a(String)

          expect(vendor[:attributes]).to have_key(:description)
          expect(vendor[:attributes][:description]).to be_a(String)

          expect(vendor[:attributes]).to have_key(:contact_name)
          expect(vendor[:attributes][:contact_name]).to be_a(String)

          expect(vendor[:attributes]).to have_key(:contact_phone)
          expect(vendor[:attributes][:contact_phone]).to be_a(String)

          expect(vendor[:attributes]).to have_key(:credit_accepted)
          expect(vendor[:attributes][:credit_accepted]).to eq(true).or eq(false)
        end
      end
    end

    context 'using a invalid market ID (sad path)' do
      it 'returns a 404 error' do
        id = 123123123123123
        get "/api/v0/markets/#{id}/vendors"

        expect(response).to_not be_successful
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
end