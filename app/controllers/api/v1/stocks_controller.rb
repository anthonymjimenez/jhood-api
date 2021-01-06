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

    def fetchAndUpdate
        #update stocks AND its user_owned_stocks -> currentValue 
        # user_owned_stocks -> totalReturn: (currentValue * sharesOwned) - totalCost
        # once stocks are update can I use user object with its stocks to update values?
        # if not will need to map thru user_owned_stocks 
    end
    private 

    def updateUsersPortfolioValue 
    end
end

    