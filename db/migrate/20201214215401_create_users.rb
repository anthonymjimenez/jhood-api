class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :pass
      t.string :name
      t.float :totalInvested
      t.float :usdBalance, default: 1000.00
      t.float :portfolioValue, default: 0.00
      t.timestamps
    end
  end
end
