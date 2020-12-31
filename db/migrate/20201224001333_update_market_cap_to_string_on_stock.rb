class UpdateMarketCapToStringOnStock < ActiveRecord::Migration[6.0]
  def change
    change_column :stocks, :marketCap, :string

  end
end
