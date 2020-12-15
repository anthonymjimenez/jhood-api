class Stock < ApplicationRecord
    has_many :user_owned_stocks
    has_many :users, through: :user_owned_stocks
end
