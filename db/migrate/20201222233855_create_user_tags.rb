class CreateUserTags < ActiveRecord::Migration[6.0]
  def change
    create_table :user_tags do |t|
      t.string :title
      t.text :stocks, array: true, default: []
      t.belongs_to :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
