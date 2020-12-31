class UpdateMarketCapOnStock < ActiveRecord::Migration[6.0]
  def change
      change_column :stocks, :marketCap, :bigint
  end
end
