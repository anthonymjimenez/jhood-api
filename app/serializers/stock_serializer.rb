class StockSerializer < ActiveModel::Serializer
  attributes :id, :symbol, :name, :latestPrice, :marketCap, :peRatio, :yearHigh, :yearLow, :ytdChange, :dailyChange, :dailyChangePercent, :tags, :isPremium, :website, :description, :sector, :CEO, :address, :city, :state, :country, :created_at, :updated_at
end

