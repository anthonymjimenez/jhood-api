
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Ringsart' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'httparty'
require 'json'
require "openssl"
UserOwnedStock.destroy_all
UserTag.destroy_all
User.destroy_all
Stock.destroy_all

def mapStocks(stocks, prem)
    uniqStocks = stocks.uniq
    uniqStocks.map { |s| 
    stockResponse = HTTParty.get("https://cloud.iexapis.com/stable/stock/#{s}/quote?token=pk_fd5c1dabf6154fe9a6cabfffe410afac",  ssl_version: :TLSv1)
    companyResponse = HTTParty.get("https://cloud.iexapis.com/stable/stock/#{s}/company?token=pk_fd5c1dabf6154fe9a6cabfffe410afac",  ssl_version: :TLSv1)
    p stockResponse.code 
    p s
    if(stockResponse.code == 200 && companyResponse.code === 200)
        stock = JSON.parse(stockResponse.body)
        company = JSON.parse(companyResponse.body)
        Stock.create({
            symbol: stock["symbol"], name: stock["companyName"], latestPrice: stock["latestPrice"], 
            marketCap: stock["marketCap"].to_s, peRatio: stock["peRatio"], yearHigh: stock["week52High"], yearLow: stock["week52Low"], 
            ytdChange: stock["ytdChange"], tags: company["tags"], dailyChange: stock["change"], dailyChangePercent: stock["changePercent"],
            website: company["website"], description: company["description"],
            sector: company["sector"], CEO: company["CEO"], 
            address: company["address"], city: company["city"], state: company["state"], country: company["country"], isPremium: prem
    })
end
}
end


premiumStocks = ['chwy', 'googl', 'dkng', 'amd', 'i',
                 'crm', 'docu', 'uber', 'roku', 'nke', 'prlb', 'tsla', 'msft', 'aapl', 'crsp', 'tgt']

regStocks = [ 'gm', 'nio',  'amzn', 'jets', 'wmt',  
            'low', 'big', 'nflx', 'dal',  'gme', 'pltr', 'jd', 'cgc', 'mo', 
            'apha', 'sq', 'tdoc', 'nvta', 'z', 'pacb', 'iova', 'cdna', 'meli',
            'pins', 'fvrr', 'twlo', 'pypl', 'se', 'arkk', 'ba', 'cat', 'jnj', 'cvx', 'ko',
            'ge', 'pfe', 'pg', 'vz', 'gs', 'hd', 'mmm', 'xom', 'ibm', 'fb', 'csco', 'mrk', 
            'nvda', 'intc', 'addyy', 'twtr', 'snap', 'amc', 'sne', 'baba', 'abnb', 'dash', 'dis',
            'acb', 'bud', 'nsrgy', 'cl', 'ul', 'gis', 'khc', 'nflx', 'tsn', 'jblu', 'ups', 'ea', 'atvi',
            'adbe', 'orcl', 'shop', 'zm', 'dell', 'zg', 'work', 'ual', 't', 'nkla', 'spce', 'sbux', 'fcel', 'znga',
            'mro', 'rcl', 'penn', 'ebay', 'mgm', 'lyv', 'wynm', 'cgc', 'acb', 'apha', 'gtec', 'dhr', 'unp', 'ups', 'rtx',
            'cat', 'mmm', 'lmt', 'eadsy', 'atvi', 'sap', 'shop', 'avgo', 'sftby', 'acn'
        ]

mapStocks(premiumStocks, true)

mapStocks(regStocks, false)

userOne = User.create({username: "antywalker", pass:"1234", name:"Anthony", usdBalance: 100.00, totalInvested: 0.00})

UserTag.create({user: userOne, stocks: ['tsla', 'chwy', 'amzn', 'nflx'], title: "My first list"})

