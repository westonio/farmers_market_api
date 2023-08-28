require 'rails_helper'

RSpec.describe 'Markets API' do
  it 'sends a list of Markets' do
    create_list(:market, 5)

    get '/api/v0/markets'

    expect(response).to be_successful

    markets = JSON.parse(response.body, symbolize_names: true)

  end
end