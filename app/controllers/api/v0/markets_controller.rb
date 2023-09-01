class Api::V0::MarketsController < ApplicationController
  def index
    render json: MarketSerializer.new(Market.all)
  end

  def show
    begin
      render json: MarketSerializer.new(Market.find(params[:id]))
    rescue ActiveRecord::RecordNotFound => e
      render json: ErrorSerializer.new(e).serialized_json, status: :not_found
    end
  end

  def search
    begin
      render json: MarketSerializer.new(Market.search(params)), status: :ok
    rescue SearchError => e
      render json: ErrorSerializer.new(e).serialized_json, status: :unprocessable_entity
    end
  end

  def nearest_atms
    begin
      market = Market.find(params[:id])
      render json: AtmSerializer.new(NearestAtmsFacade.new.nearest_atms(market.lat, market.lon))
    rescue ActiveRecord::RecordNotFound => e
      render json: ErrorSerializer.new(e).serialized_json, status: :not_found
    end
  end
end 