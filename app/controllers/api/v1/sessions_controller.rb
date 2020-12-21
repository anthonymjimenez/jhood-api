class Api::V1::SessionsController < ApplicationController
  
    def create
      user = User.find_by(username: params[:username])
      if user && user.pass == params[:pass]
        render json: user, status: :accepted
      else
        render json: { message: 'Invalid username and/or password' }, status: :bad_request
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
        render json: {errors: current_user.errors.full_messages}, status: :bad_request
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