class Api::V1::SessionsController < ApplicationController
  
    def create
      p params
      p User.all
      @user = User.find_by(username: params[:username])
      if @user && @user.pass == params[:pass]
        render json: { user: @user, message: "Welcome back, #{@user.name}"}, status: :accepted
      else
        render json: { message: 'Invalid username and/or password' }, status: :unauthorized
      end
    end
  
    # def destroy
    #   session.delete :user_id
    #   render json: { status: 200, logged_out: true}
    # end
  
    def auto_login
      if current_user
        render json: current_user
      else
        render json: {errors: "No user logged in"}, status: :unauthorized
      end
    end
  
    def user_auth
      render json: {message: "You are authorized"}
    end
  
    private
  

    def current_user
        @user = User.find_by(id: params[:id])
    end
  end