require 'rails_helper'

RSpec.describe Atm do
  before(:each) do
    atm_data = {"type":"POI","id":"WRfWd3Yw-NKoRmYhtSkF5w","score":99.9858627319,"dist":14.140255,"info":"search:ta:840089002545788-US","poi":{"name":"Lynk Systems","categorySet":[{"id":7397}],"categories":["cash dispenser"],"classifications":[{"code":"CASH_DISPENSER","names":[{"nameLocale":"en-US","name":"cash dispenser"}]}]},"address":{"streetNumber":"785","streetName":"North Colorado Boulevard","municipalitySubdivision":"Congress Park","municipality":"Denver","countrySecondarySubdivision":"Denver","countrySubdivision":"CO","countrySubdivisionName":"Colorado","postalCode":"80206","extendedPostalCode":"80206-4035","countryCode":"US","country":"United States","countryCodeISO3":"USA","freeformAddress":"785 North Colorado Boulevard, Denver, CO 80206","localName":"Denver"},"position":{"lat":39.72884,"lon":-104.940903},"viewport":{"topLeftPoint":{"lat":39.72974,"lon":-104.94207},"btmRightPoint":{"lat":39.72794,"lon":-104.93973}},"entryPoints":[{"type":"main","position":{"lat":39.72885,"lon":-104.94079}}]}
    @atm = Atm.new(atm_data)
  end

  it 'exists' do
    expect(@atm).to be_a(Atm)
  end

  it 'has a name' do
    expect(@atm.name).to eq("Lynk Systems")
  end

  it 'has a distance' do
    expect(@atm.distance).to eq(14.140255)
  end

  it 'has an address' do
    expect(@atm.address).to eq("785 North Colorado Boulevard, Denver, CO 80206")
  end

  it 'has a latitude and longitude' do
    expect(@atm.lat).to eq(39.72884)
    expect(@atm.lon).to eq(-104.940903)
  end
end