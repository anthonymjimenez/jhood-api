class Api::V1::UserOwnedStocksController < ApplicationController 
   # should probably add to port value when bought
    
    def create
        # only allow one per stock,user Person.where(name: 'Spartacus', rating: 4).exists?
        stock = Stock.find(params[:stock])
        user = User.find(params[:user])
        averageCost = stock.latestPrice
        totalCost = params[:sharesOwned] * averageCost
        ##validate balance
        usdBalance = user.usdBalance - totalCost
        p UserOwnedStock.where(stock: stock, user: user)
        if(UserOwnedStock.where(stock: stock, user: user).exists? || usdBalance < 1)
            render json: {error: "Purchase cannot exceed balance"}, status: :bad_request
            return false
        end
       
        
        totalInvested = user.totalInvested + totalCost
        user.update(:usdBalance => usdBalance, :totalInvested => totalInvested)
        user_owned_stock = UserOwnedStock.create(sharesOwned: params[:sharesOwned], totalCost: totalCost, symbol: stock.symbol, averageCost: averageCost, totalReturn: 0, returnPercentage: 0, stock: Stock.find(params[:stock]), user: User.find(params[:user]))
        if(user_owned_stock.valid?)
            render json: { user_owned_stock: UserOwnedStockSerializer.new(user_owned_stock)}, status: :created
        else
            render json: {errors: user_owned_stock.errors.full_messages}, status: :bad_request
        end
    end
    
    def sell_stock
        userData = UserOwnedStock.find(params[:user_stock_id])
        if(params[:sharesSold] > userData.sharesOwned || userData == nil) 
            render json: { error: "Can not sell more than you own"}, status: :bad_request
            return false
        end
        
        sharesOwned = userData.sharesOwned - params[:sharesSold]
        #validate that sharesOwned is not less than 0 
        # totalCapital = sharesOwned * stock.latestPrice
 
        totalCost = userData.averageCost * params[:sharesSold]
        userTotalInvested = userData.user.totalInvested.round(2) - totalCost
        
        totalGain = userData.stock.latestPrice * params[:sharesSold]
        userBalance = userData.user.usdBalance + totalGain 

        currentValue = userData.stock.latestPrice * sharesOwned
        
        initValue = sharesOwned * userData.averageCost

        totalReturn = currentValue - initValue

        totalReturnPercentage = totalReturn / initValue
        userData.update(:totalCost => totalCost, :sharesOwned => sharesOwned, :totalReturn => totalReturn, :returnPercentage => totalReturnPercentage * 100)
        
        userData.user.update(:totalInvested => userTotalInvested, :usdBalance => userBalance)
        user = userData.user

        if sharesOwned == 0
            userData.destroy 
            render json: { deleted: true, user: user  }, status: :accepted
        else
            userData.update(:totalCost => userTotalInvested, :sharesOwned => sharesOwned)
            render json: userData
        end
    end

    def buy_stock
        userData = UserOwnedStock.find(params[:user_stock_id])
        transactionCost = userData.stock.latestPrice * params[:sharesBought]
        ## if transaction is greater than balance reject
        if(transactionCost > userData.user.usdBalance)
            render json: { error: "Purchase cannot exceed balance"}, status: :bad_request
            return false
        end
        userTotalInvested = userData.user.totalInvested + transactionCost
        userBalance = userData.user.usdBalance - transactionCost

        totalCost = userData.totalCost + transactionCost
        
        sharesOwned = userData.sharesOwned + params[:sharesBought]
        
        averageCost = totalCost / sharesOwned
        
        currentValue = userData.stock.latestPrice * sharesOwned
        
        initValue = sharesOwned * averageCost

        totalReturn = currentValue - initValue

        totalReturnPercentage = totalReturn / initValue
        userData.update(:totalCost => totalCost, :sharesOwned => sharesOwned, :averageCost => averageCost, :totalReturn => totalReturn, :returnPercentage => totalReturnPercentage * 100)
        
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
    