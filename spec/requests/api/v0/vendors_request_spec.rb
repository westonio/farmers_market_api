require 'rails_helper'

RSpec.describe 'Vendors API' do
  before(:each) do
    @market1 = create(:market)
    @market2 = create(:market)
    
    vendor_ids = create_list(:vendor, 5).pluck(:id)

    @market_vendor1 = @market1.market_vendors.create!(vendor_id: vendor_ids[0])
    
    @market1.market_vendors.create!(vendor_id: vendor_ids[1])
    @market1.market_vendors.create!(vendor_id: vendor_ids[2])
    @market1.market_vendors.create!(vendor_id: vendor_ids[3])
    @market1.market_vendors.create!(vendor_id: vendor_ids[4])
  end
  
  describe 'GET /vendors/:id' do
    context 'using a valid vendor ID (happy path)' do
      it 'returns the vendors details' do
        vendor_id = @market_vendor1.vendor_id

        get "/api/v0/vendors/#{vendor_id}"
        
        expect(response).to be_successful

        vendor = JSON.parse(response.body, symbolize_names: true)[:data]

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

    context 'using a invalid vendor ID (sad path)' do
      it 'returns a 404 error' do
        vendor_id = 123123123123123

        get "/api/v0/vendors/#{vendor_id}"
        
        expect(response).to_not be_successful
        expect(response.status).to eq(404)

        not_found = JSON.parse(response.body, symbolize_names: true)

        expect(not_found).to have_key(:errors)
        expect(not_found[:errors]).to be_an(Array)

        expect(not_found[:errors].first).to have_key(:details)
        expect(not_found[:errors].first[:details]).to be_a(String)
        expect(not_found[:errors].first[:details]).to eq("Couldn't find Vendor with 'id'=123123123123123")
      end
    end
  end
end