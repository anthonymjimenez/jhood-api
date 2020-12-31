class User < ApplicationRecord
    validates_uniqueness_of :username
    has_many :user_tags
    has_many :user_owned_stocks
    has_many :stocks, through: :user_owned_stocks
end
