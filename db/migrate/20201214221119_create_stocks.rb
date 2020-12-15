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

      t.timestamps
    end
  end
end
