require 'rails_helper'

RSpec.describe Vendor, type: :model do
  describe 'Associations' do
    it { should have_many :market_vendors}
    it { should have_many :markets}
  end

  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :contact_name }
    it { should validate_presence_of :contact_phone }
  end
end