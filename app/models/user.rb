class User < ApplicationRecord
    has_many :user_owned_stocks
    has_many :stocks, through: :user_owned_stocks
end
