class Api::V1::UserOwnedStocksController < ApplicationController 
    def create
        # only allow one per stock,user Person.where(name: 'Spartacus', rating: 4).exists?
        stock = Stock.find(params[:stock])
        user = User.find(params[:user])
        averageCost = stock.latestPrice
        totalCost = params[:sharesOwned] * averageCost
        ##validate balance
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
        totalGain = userData.stock.latestPrice * params[:sharesSold]

        sharesOwned = userData.sharesOwned - params[:sharesSold]
        #validate that sharesOwned is not less than 0 
        # totalCapital = sharesOwned * stock.latestPrice
        p totalGain
        p sharesOwned
        p userData.user.totalInvested.round(2)
        userTotalInvested = userData.user.totalInvested.round(2) - totalGain
        userBalance = userData.user.usdBalance + totalGain
        
        p userTotalInvested
        userData.user.update(:totalInvested => userTotalInvested, :usdBalance => userBalance)

        if sharesOwned == 0
            userData.destroy 
            render json: { deleted: true }, status: :accepted
        else
            userData.update(:totalCost => userTotalInvested, :sharesOwned => sharesOwned)
            render json: userData
        end
    end

    def buy_stock
        userData = UserOwnedStock.find(params[:user_stock_id])
        transactionCost = userData.stock.latestPrice * params[:sharesBought]
        ## if transaction is greater than balance reject
        userTotalInvested = userData.user.totalInvested + transactionCost
        userBalance = userData.user.usdBalance - transactionCost

        totalCost = userData.totalCost + transactionCost
        sharesOwned = userData.sharesOwned + params[:sharesBought]
        averageCost = totalCost / sharesOwned
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
    