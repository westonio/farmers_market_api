class MarketVendor < ApplicationRecord
  belongs_to :market
  belongs_to :vendor

  after_save :update_vendor_count
  after_destroy :update_vendor_count
  
  private

  def update_vendor_count
    market.update(vendor_count: market.vendors.count)
  end
end