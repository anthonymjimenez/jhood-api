class AddDetailsToStocks < ActiveRecord::Migration[6.0]
  def change
    add_column :stocks, :address, :string
    add_column :stocks, :city, :string
    add_column :stocks, :state, :string
    add_column :stocks, :country, :string

  end
end
