class UserOwnedStockSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :sharesOwned, :totalCost, :symbol, :averageCost, :created_at, :updated_at
  belongs_to :stock
  belongs_to :user
end