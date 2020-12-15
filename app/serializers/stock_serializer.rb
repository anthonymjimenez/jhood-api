class StockSerializer < ActiveModel::Serializer
  attributes :id, :symbol, :name, :latestPrice, :marketCap, :peRatio, :yearHigh, :yearLow, :ytdChange, :created_at, :updated_at
  has_many :user_owned_stocks
end

