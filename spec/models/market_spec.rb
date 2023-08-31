require 'rails_helper'

RSpec.describe Market, type: :model do
  describe 'Associations' do
    it { should have_many :market_vendors }
    it { should have_many :vendors }
  end

  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :street }
    it { should validate_presence_of :county }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :lat }
    it { should validate_presence_of :lon }
  end


  describe 'Model Methods' do
    before(:each) do
      @market1 = create(:market, name: 'Sunflower Market', city: 'Denver', state: 'Colorado')
      @market2 = create(:market, name: 'Western Market', city: 'Denver', state: 'Colorado')
      @market3 = create(:market, name: 'Abundant Farms', city: 'Seattle', state: 'Washington')
      @market4 = create(:market, name: 'Spring Festival Market', city: 'Los Angeles', state: 'California')
      @market5 = create(:market, name: 'Green Market', city: 'Los Angeles', state: 'California')
      @market6 = create(:market, name: 'Mother Natures Picks', city: 'Los Angeles', state: 'California')
    end

    it '#self.filter_name' do
      markets = Market.all
      search = Market.filter_name(markets, "Sunflower Market")

      expect(search.count).to eq(1)

      expect(search.first[:id]).to eq(@market1.id)
      expect(search.first[:name]).to eq(@market1.name)
      expect(search.first[:street]).to eq(@market1.street)
      expect(search.first[:city]).to eq(@market1.city)
      expect(search.first[:county]).to eq(@market1.county)
      expect(search.first[:state]).to eq(@market1.state)
      expect(search.first[:zip]).to eq(@market1.zip)
      expect(search.first[:lat]).to eq(@market1.lat)
      expect(search.first[:lon]).to eq(@market1.lon)
    end

    it '#self.filter_city' do
      markets = Market.all
      search = Market.filter_city(markets, 'Denver')

      expect(search.count).to eq(2)

      expect(search.first[:id]).to eq(@market1.id)
      expect(search.first[:name]).to eq(@market1.name)
      expect(search.first[:city]).to eq(@market1.city)

      expect(search[1][:id]).to eq(@market2.id)
      expect(search[1][:name]).to eq(@market2.name)
      expect(search[1][:city]).to eq(@market2.city)
    end

    it '#self.filter_state' do
      markets = Market.all
      search = Market.filter_state(markets, 'Washington')

      expect(search.count).to eq(1)

      expect(search.first[:id]).to eq(@market3.id)
      expect(search.first[:name]).to eq(@market3.name)
      expect(search.first[:state]).to eq(@market3.state)
    end

    it '#self.find_markets' do
      params = { city: 'Los Angeles', state: 'California' }
      search = Market.find_markets(params)

      expect(search.count).to eq(3)

      expect(search.first[:id]).to eq(@market4.id)
      expect(search.first[:name]).to eq(@market4.name)
      expect(search.first[:state]).to eq(@market4.state)

      expect(search[1][:id]).to eq(@market5.id)
      expect(search[1][:name]).to eq(@market5.name)
      expect(search[1][:state]).to eq(@market5.state)
      
      expect(search[2][:id]).to eq(@market6.id)
      expect(search[2][:name]).to eq(@market6.name)
      expect(search[2][:state]).to eq(@market6.state)
    end

    it '#self.validate_params returns true when valid' do
      params1 = { state: 'California' }
      params2 = { city: 'Los Angeles', state: 'California' }
      params3 = { name: 'Green Market', city: 'Los Angeles', state: 'California' }
      params4 = { name: 'Green Market', state: 'California' }
      params5 = { name: 'Green Market' }


      expect(Market.validate_params(params1)).to eq(true)
      expect(Market.validate_params(params2)).to eq(true)
      expect(Market.validate_params(params3)).to eq(true)
      expect(Market.validate_params(params4)).to eq(true)
      expect(Market.validate_params(params5)).to eq(true)
    end

    it '#self.validate_params returns false when invalid' do
      params1 = { city: 'Los Angeles' } #cannot search city only
      params2 = { city: 'Los Angeles', name: 'Green Market' } #cannot search city and name only
      params3 = { county: 'Los Angeles' } #cannot search using other parameters

      expect(Market.validate_params(params1)).to eq(false)
      expect(Market.validate_params(params2)).to eq(false)
      expect(Market.validate_params(params3)).to eq(false)
    end

    it '#self.search returns markets when valid params searched' do
      params = { city: 'Los Angeles', state: 'California' }
      search = Market.search(params)

      expect(search.count).to eq(3)
    end
    
    it '#self.search returns error when invalid params searched' do
      params = { county: 'Los Angeles' }

      expect{ Market.search(params) }.to raise_error(SearchError)
    end
  end
end