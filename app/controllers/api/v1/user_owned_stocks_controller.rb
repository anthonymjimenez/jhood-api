class Api::V1::UserOwnedStocksController < ApplicationController 
    def create
        stock = Stock.find(params[:stock])
        user = User.find(params[:user])
        averageCost = stock.latestPrice
        totalCost = params[:sharesOwned] * averageCost
        usdBalance = user.usdBalance - totalCost
        totalInvested = user.totalInvested + totalCost
        user.update(:usdBalance => usdBalance, :totalInvested => totalInvested)
        user_owned_stock = UserOwnedStock.create(sharesOwned: params[:sharesOwned], totalCost: totalCost, symbol: params[:symbol], averageCost: averageCost, stock: Stock.find(params[:stock]), user: User.find(params[:user]))
        if(user_owned_stock.valid?)
            render json: { user_owned_stock: UserOwnedStockSerializer.new(user_owned_stock)}, status: :created
        else
            render json: {errors: user_owned_stock.errors.full_messages}, status: :not_acceptable
        end
    end
    
    def sell_stock
        userData = UserOwnedStock.find(params[:user_stock_id])
        totalCost = userData.stock.latestPrice * params[:sharesSold]
        sharesOwned = userData.sharesOwned - params[:sharesSold]

        userTotalInvested = userData.user.totalInvested - totalCost
        userBalance = userData.user.usdBalance + totalCost
        
        userData.update(:totalCost => totalCost, :sharesOwned => sharesOwned)
        userData.user.update(:totalInvested => userTotalInvested, :usdBalance => userBalance)

        render json: userData
    end

    def buy_stock
        userData = UserOwnedStock.find(params[:user_stock_id])
        totalCost = userData.stock.latestPrice * params[:sharesBought]
        sharesOwned = userData.sharesOwned + params[:sharesBought]
        averageCost = totalCost / sharesOwned
        userTotalInvested = userData.user.totalInvested + totalCost
        userBalance = userData.user.usdBalance - totalCost
        userData.update(:totalCost => totalCost, :sharesOwned => sharesOwned, :averageCost => averageCost)
        userData.user.update(:totalInvested => userTotalInvested, :usdBalance => userBalance)

        render json: userData
    end

    def update 
    end
    private

    def user_owned_stock_params
        params.require(:user_owned_stock).permit(
            :sharesOwned,
            :symbol,
        ) # cant do until posting from frontend
    end
end
    