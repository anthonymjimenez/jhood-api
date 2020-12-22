class Api::V1::StocksController < ApplicationController 
    def index
        stocks = Stock.all
        p stocks[0].users
        render json: stocks
    end
    
    def show 
        stock = Stock.find(params[:id])
        render json: stock
    end
end

    