class Api::V0::MarketsController < ApplicationController
  def index
    render json: MarketSerializer.new(Market.all)
  end

  def show
    begin
      render json: MarketSerializer.new(Market.find(params[:id]))
    rescue StandardError => e
      render json: ErrorMarketSerializer.new(e).serialized_json, status: :not_found
    end
  end
end 