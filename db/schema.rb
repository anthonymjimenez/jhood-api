# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_14_221709) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "stocks", force: :cascade do |t|
    t.string "symbol"
    t.string "name"
    t.float "latestPrice"
    t.integer "marketCap"
    t.float "peRatio"
    t.float "yearHigh"
    t.float "yearLow"
    t.float "ytdChange"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_owned_stocks", force: :cascade do |t|
    t.string "symbol"
    t.float "averageCost"
    t.float "sharesOwned"
    t.float "totalCost"
    t.bigint "stock_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stock_id"], name: "index_user_owned_stocks_on_stock_id"
    t.index ["user_id"], name: "index_user_owned_stocks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "pass"
    t.string "name"
    t.float "totalInvested"
    t.float "usdBalance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "user_owned_stocks", "stocks"
  add_foreign_key "user_owned_stocks", "users"
end
