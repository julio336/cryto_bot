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
    crypto_pair.each do |crypto, pair|
      url_rsi = "https://api.taapi.io/rsi?secret=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imp1bGlvMzM2QGhvdG1haWwuY29tIiwiaWF0IjoxNjEzMDA4ODgyLCJleHAiOjc5MjAyMDg4ODJ9.Kuut9k7NMH-TPQQmV6YdjgmYyH7wlGR4ZQmB8x1WhTA&exchange=binance&symbol=#{pair}&interval=1h"
      resp_rsi = Net::HTTP.get_response(URI.parse(url_rsi))
      url_macd = "https://api.taapi.io/macd?secret=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imp1bGlvMzM2QGhvdG1haWwuY29tIiwiaWF0IjoxNjEzMDA4ODgyLCJleHAiOjc5MjAyMDg4ODJ9.Kuut9k7NMH-TPQQmV6YdjgmYyH7wlGR4ZQmB8x1WhTA&exchange=binance&symbol=#{pair}&interval=15m"
      resp_macd = Net::HTTP.get_response(URI.parse(url_macd))
      data_rsi = JSON.parse(resp_rsi.body)
      data_macd = JSON.parse(resp_macd.body)
      puts data_macd
      if data_macd['valueMACDSignal'] > data_macd['valueMACD'] and (data_macd['valueMACD']/data_macd['valueMACDSignal']) > 0.9
        puts pair
        puts "Señal de venta"
        ApplicationMailer.senal_venta(pair).deliver
      end
      if data_macd['valueMACD'] > data_macd['valueMACDSignal'] and (data_macd['valueMACD']/data_macd['valueMACDSignal']) > 0.9
        puts pair
        puts "Señal de compra"
        ApplicationMailer.senal_compra(pair).deliver
      end
      puts data_rsi
      if data_rsi['value'] <= 35 || data_rsi['value'] > 70
        crypto_arr.store(pair, data_rsi['value'])
        puts crypto_arr
      else
        puts data_rsi
      end
    end
    if !crypto_arr.empty?
      puts "Email enviado"
      ApplicationMailer.test_email(crypto_arr).deliver
    end
  end
end

