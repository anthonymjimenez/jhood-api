class UserOwnedStockSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :stock_id, :sharesOwned, :totalCost, :symbol, :averageCost, :totalReturn, :returnPercentage, :created_at, :updated_at
  belongs_to :stock
  belongs_to :user
end
