require "net/http"

namespace :scheduled_tasks do
  desc "Sync with some source"
  task update: :environment do
    count = 0
    puts "There are x number of things to update"
    
    puts "done."
  end
  desc "Check if can update more..?"
    task poll: :environment do
      puts "Number of Things not yet completed is"
  end
  task :mailme => :environment do
    crypto_pair = {"btc" => "BTC/USDT", "eth" => "ETH/USDT", "xrp" => "XRP/USDT", "ltc" => "LTC/USDT", "xmr" => "XMR/USDT"}
    #crypto_pair = {"btc" => "BTC/USDT"}
    crypto_arr = Hash.new
    price_arr = Hash.new
    crypto_pair.each do |crypto, pair|
    #url_rsi = "https://api.taapi.io/rsi?secret=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imp1bGlvMzM2QGhvdG1haWwuY29tIiwiaWF0IjoxNjEzMDA4ODgyLCJleHAiOjc5MjAyMDg4ODJ9.Kuut9k7NMH-TPQQmV6YdjgmYyH7wlGR4ZQmB8x1WhTA&exchange=binance&symbol=#{pair}&interval=1h"
    #resp_rsi = Net::HTTP.get_response(URI.parse(url_rsi))
    #data_rsi = JSON.parse(resp_rsi.body)
      url_st = "https://api.taapi.io/supertrend?secret=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imp1bGlvMzM2QGhvdG1haWwuY29tIiwiaWF0IjoxNjEzMDA4ODgyLCJleHAiOjc5MjAyMDg4ODJ9.Kuut9k7NMH-TPQQmV6YdjgmYyH7wlGR4ZQmB8x1WhTA&exchange=binance&symbol=#{pair}&interval=1h"
      price = "https://api.taapi.io/typprice?secret=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imp1bGlvMzM2QGhvdG1haWwuY29tIiwiaWF0IjoxNjEzMDA4ODgyLCJleHAiOjc5MjAyMDg4ODJ9.Kuut9k7NMH-TPQQmV6YdjgmYyH7wlGR4ZQmB8x1WhTA&exchange=binance&symbol=#{pair}&interval=1h"
      resp_st = Net::HTTP.get_response(URI.parse(url_st))
      data_st = JSON.parse(resp_st.body)
      resp_price = Net::HTTP.get_response(URI.parse(price))
      data_price = JSON.parse(resp_price.body)

=begin
      url_macd = "https://api.taapi.io/macd?secret=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imp1bGlvMzM2QGhvdG1haWwuY29tIiwiaWF0IjoxNjEzMDA4ODgyLCJleHAiOjc5MjAyMDg4ODJ9.Kuut9k7NMH-TPQQmV6YdjgmYyH7wlGR4ZQmB8x1WhTA&exchange=binance&symbol=#{pair}&interval=4h"
      resp_macd = Net::HTTP.get_response(URI.parse(url_macd))
      data_macd = JSON.parse(resp_macd.body)
        puts data_macd
        venta = (data_macd['valueMACD']/data_macd['valueMACDSignal']).abs
        puts venta
        if data_macd['valueMACDSignal'] > data_macd['valueMACD'] and (venta > 0.9 && venta < 1)
          puts pair
          puts "Señal de venta"
          ApplicationMailer.senal_venta(pair, data_macd, venta).deliver
        end
        compra = (data_macd['valueMACD']/data_macd['valueMACDSignal']).abs
        puts compra
        if data_macd['valueMACD'] > data_macd['valueMACDSignal'] and (compra < 1 && compra >0.9)
          puts pair
          puts "Señal de compra"
          ApplicationMailer.senal_compra(pair, data_macd, compra).deliver
        end
=end
      #puts data_rsi
      crypto_arr.store(pair, data_st)
      price_arr.store(pair, data_price)
      
=begin
      if data_rsi['value'] <= 30 || data_rsi['value'] > 70
        crypto_arr.store(pair, data_rsi['value'])
        puts crypto_arr
      else
        puts data_rsi
      end
=end
    end
    ApplicationMailer.test_email(crypto_arr, price_arr).deliver

=begin
    if !crypto_arr.empty?
      puts "Email enviado"
      ApplicationMailer.test_email(crypto_arr).deliver
    end
=end
  end
end

