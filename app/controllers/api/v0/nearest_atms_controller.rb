class Api::V0::NearestAtmsController < ApplicationController
  def index
    begin
      market = Market.find(params[:market_id])
      render json: AtmSerializer.new(NearestAtmsFacade.new.nearest_atms(market.lat, market.lon))
    rescue ActiveRecord::RecordNotFound => e
      render json: ErrorSerializer.new(e).serialized_json, status: :not_found
    end
  end
end