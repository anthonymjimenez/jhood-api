# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
UserOwnedStock.destroy_all
User.destroy_all
Stock.destroy_all

userOne = User.create({username: "antywalker", pass:"1234", name:"Anthony", usdBalance: 100.00, totalInvested: 0.00})

apple = Stock.create({symbol: "APPL", name: "Apple", latestPrice: 65.23, marketCap: 1000000, peRatio: 1.12, yearHigh:100, yearLow: 23, ytdChange: 12.12})

ibm = Stock.create({symbol: "IBM", name: "IBM", latestPrice: 15.23, marketCap: 1600000, peRatio: 0.12, yearHigh:500, yearLow: 21, ytdChange: 8.12})

ford = Stock.create({symbol: "F", name: "Ford", latestPrice: 9.3, marketCap: 18000, peRatio: 0.62, yearHigh:10, yearLow: 4, ytdChange: 4.12})

UserOwnedStock.create({stock: apple, user: userOne, symbol: "APPL", averageCost: 62, sharesOwned: 2, totalCost: 124})
