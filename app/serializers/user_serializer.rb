class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :pass, :name, :totalInvested, :usdBalance, :portfolioValue, :created_at, :updated_at
  has_many :user_tags
  has_many :user_owned_stocks
  has_many :stocks, through: :user_owned_stocks
end
