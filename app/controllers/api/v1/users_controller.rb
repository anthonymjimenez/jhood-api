class Api::V1::UsersController < ApplicationController
  
    def create
      @user = User.create(user_params)
      if @user.valid?
        render json: { user: UserSerializer.new(@user)}, status: :created
      else
        render json: {errors: @user.errors.full_messages}, status: :not_acceptable
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
        :age,
        :totalInvested,
        :usdBalance
        ) 
      # :avatar
    end
  
    def balance
      params.require(:user).permit(:usdBalance)
    end

    def totalInvested
        params.require(:user).permit(:totalInvested)
    end


  
  end