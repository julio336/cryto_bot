require "net/http"

namespace :scheduled_tasks do
  desc "Sync with some source"
  task update: :environment do
    puts "There are x number of things to update"
    
    puts "done."
  end
  desc "Check if can update more..?"
    task poll: :environment do
      puts "Number of Things not yet completed is"
  end
  task :mailme => :environment do
    #crypto_pair = {"btc"=>"BTC/USDT", "eth" => "ETH/USDT", "xrp" => "XRP/USDT", "ltc" => "LTC/USDT", "xmr" => "XMR/USDT"}
    crypto_pair = {"btc"=>"BTC/USDT"}
    crypto_arr = Hash.new
    #price_arr = Hash.new
    crypto_pair.each do |crypto, pair|
    #url_rsi = "https://api.taapi.io/rsi?secret=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imp1bGlvMzM2QGhvdG1haWwuY29tIiwiaWF0IjoxNjEzMDA4ODgyLCJleHAiOjc5MjAyMDg4ODJ9.Kuut9k7NMH-TPQQmV6YdjgmYyH7wlGR4ZQmB8x1WhTA&exchange=binance&symbol=#{pair}&interval=1h"
    #resp_rsi = Net::HTTP.get_response(URI.parse(url_rsi))
    #data_rsi = JSON.parse(resp_rsi.body)
      #url_st = "https://api.taapi.io/supertrend?secret=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imp1bGlvMzM2QGhvdG1haWwuY29tIiwiaWF0IjoxNjEzMDA4ODgyLCJleHAiOjc5MjAyMDg4ODJ9.Kuut9k7NMH-TPQQmV6YdjgmYyH7wlGR4ZQmB8x1WhTA&exchange=binance&symbol=#{pair}&interval=1h"
      url_candle = "https://api.taapi.io/candle?secret=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imp1bGlvMzM2QGhvdG1haWwuY29tIiwiaWF0IjoxNjEzMDA4ODgyLCJleHAiOjc5MjAyMDg4ODJ9.Kuut9k7NMH-TPQQmV6YdjgmYyH7wlGR4ZQmB8x1WhTA&exchange=binance&symbol=#{pair}&interval=15m"
      #price = "https://api.taapi.io/typprice?secret=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imp1bGlvMzM2QGhvdG1haWwuY29tIiwiaWF0IjoxNjEzMDA4ODgyLCJleHAiOjc5MjAyMDg4ODJ9.Kuut9k7NMH-TPQQmV6YdjgmYyH7wlGR4ZQmB8x1WhTA&exchange=binance&symbol=#{pair}&interval=1h"
      resp_candle = Net::HTTP.get_response(URI.parse(url_candle))
      data_candle = JSON.parse(resp_candle.body)
      puts data_candle
      #evaluation = (data_price['value']/data_st['value'])
      #puts evaluation
      #porcent = ((1-evaluation).abs)*100
      #puts porcent
      #if porcent < 2
      crypto_arr.store(pair, data_candle)
        #price_arr.store(pair, data_price)
      #end
    end
    #puts crypto_arr
    #if !crypto_arr.empty?
     # puts "Email enviado"
      #ApplicationMailer.test_email(crypto_arr, price_arr).deliver
    #end
  end
end

