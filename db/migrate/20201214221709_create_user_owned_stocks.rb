class CreateUserOwnedStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :user_owned_stocks do |t|

      t.string :symbol
      t.float :averageCost
      t.float :sharesOwned
      t.float :totalCost

      t.belongs_to :stock, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
