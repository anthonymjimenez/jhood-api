class Api::V1::UserOwnedStocksController < ApplicationController 
    def create
        user_owned_stock = UserOwnedStock.create(sharesOwned: params[:sharesOwned], totalCost: params[:totalCost], symbol: params[:symbol], averageCost: params[:averageCost], stock: Stock.find(params[:stock]), user: User.find(params[:user]))
        if(user_owned_stock.valid?)
            render json: { user_owned_stock: UserOwnedStockSerializer.new(user_owned_stock)}, status: :created
        else
            render json: {errors: user_owned_stock.errors.full_messages}, status: :not_acceptable
        end
    end

    private

    def user_owned_stock_params
        params.require(:user_owned_stock).permit(
            :sharesOwned,
            :totalCost,
            :symbol,
            :averageCost
        ) # cant do until posting from frontend
    end
end
    