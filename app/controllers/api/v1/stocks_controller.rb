class Api::V1::StocksController < ApplicationController 
    def index
        stocks = Stock.all
        p stocks[0].users
        render json: stocks
    end

    def stock_list
        stocks = Stock.all
        stocks.map{ |stock| 
        p stock.user_owned_stocks
    } # ask about tomorrow 
    render json: stocks
    end
    
    def show 
        stock = Stock.find(params[:id])
        render json: stock
    end
end

    