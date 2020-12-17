class Api::V1::UsersController < ApplicationController
  
    def create
      @user = User.create(user_params)
      if @user.valid?
        render json: { user: UserSerializer.new(@user)}, status: :created
      else
        render json: {errors: @user.errors.full_messages}, status: :not_acceptable
    end
    end
  
    def update_balance
      user = User.find(params[:id])
      newB = params[:balance] + user.usdBalance
      if user.update(user_params.merge({usdBalance: newB}))
        render json: { user: UserSerializer.new(user) }, status: :accepted
      else
        render json: { errors: @user.errors.full_messages }, status: :not_acceptable
      end 
    end
  
  def destroy
    if @user
      @user.destroy
    else
      render json: { errors: ["User does not exist, delete failed"] }, status: :not_acceptable
    end
  end

    private
    def user_params
      params.require(:user).permit(
        :username,
        :pass,
        :name, 
        :totalInvested,
        :usdBalance
        ) 
      # :avatar
    end


  
  end