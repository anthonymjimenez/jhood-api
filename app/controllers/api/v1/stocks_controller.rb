class Api::V1::StocksController < ApplicationController 
    def index
        p params
        stocks = Stock.all
        render json: stocks
    end

    def show 
        stock = Stock.find(params[:id])
        render json: stock
    end
end

    