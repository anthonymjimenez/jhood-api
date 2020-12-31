class Api::V1::UserTagsController < ApplicationController
    def create
        user = findUser()
        if(UserTag.where(title: params[:title], user: user).exists?)
            render json: {error: "List already exist"}, status: :bad_request
            return false
        end
        UserTag.create({user: user, stocks: params[:stocks], title: params[:title]})
        tags = user.user_tags
        render json: tags
    end

    def addStock
        user = findUser()
        tag = findTag()
        tags = user.user_tags
        if(tag.stocks.include?(params[:stock]))
            render json: { error: "Already added this stock"}, status: :bad_request
            return false
        end
        p user
        p tag
        newList = tag.stocks.push(params[:stock])
        tag.update(:stocks => newList)
        render json: tags
    end

    def removeStock
        user = findUser()
        tag = findTag()
        tags = user.user_tags
        if(!tag.stocks.include?(params[:stock]))
            render json: { error: "This stock is not included in the list"}, status: :bad_request
            return false
        end

        newList = tag.stocks - [params[:stock]]
        tag.update(:stocks => newList)
        render json: tags
    end

    def delete
        user = findUser()
        tag = findTag(user)
        if tag
          tag.destroy
          render json: {deleted: true}
        else
          render json: { errors: ["User does not exist, delete failed"] }, status: :bad_request
        end
    end

    private 
    
    def findUser
        User.find(params[:user])
    end
    
    def findTag
        UserTag.find(params[:user_tag])
    end

end
