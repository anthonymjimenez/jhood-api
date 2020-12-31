class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :name
      t.float :latestPrice
      t.integer :marketCap
      t.float :peRatio
      t.float :yearHigh
      t.float :yearLow
      t.float :ytdChange
      t.float :dailyChange
      t.float :dailyChangePercent
      t.boolean :isPremium, :default => false
      #tags
      t.text :tags, array: true, default: []
      ##company info
      t.string :website
      t.string :description
      t.string :sector
      t.string :CEO
      t.timestamps
    end
  end
end
