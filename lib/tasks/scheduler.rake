require "net/http"
require 'bundler'
require 'google/api_client/client_secrets'
Bundler.require


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


  task :supertrendmail => :environment do
        #crypto_pair = {"btc"=>"BTC/USDT", "eth" => "ETH/USDT", "xrp" => "XRP/USDT", "ltc" => "LTC/USDT", "xmr" => "XMR/USDT", "sol" => "SOL/USDT"}
    crypto_pair = {"btc"=>"BTC/USDT", "eth"=>"ETH/USDT", "ltc"=>"LTC/USDT", "xrp" => "XRP/USDT","dot" => "DOT/USDT", "sol"=>"SOL/USDT", "axs" => "AXS/USDT", "bnb" => "BNB/USDT", "mana" => "MANA/USDT", "avax" => "AVAX/USDT"}
    crypto_arr = Array.new
    valueAdvice = ""
    counter = 1

    crypto_pair.each do |crypto, pair|
      puts pair
      if pair == "BTC/USDT"
        url_st= "https://api.taapi.io/supertrend?secret=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imp1bGlvMzM2QGhvdG1haWwuY29tIiwiaWF0IjoxNjEzMDA4ODgyLCJleHAiOjc5MjAyMDg4ODJ9.Kuut9k7NMH-TPQQmV6YdjgmYyH7wlGR4ZQmB8x1WhTA&exchange=binance&symbol=#{pair}&interval=1d"
      else
        url_st= "https://api.taapi.io/supertrend?secret=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imp1bGlvMzM2QGhvdG1haWwuY29tIiwiaWF0IjoxNjEzMDA4ODgyLCJleHAiOjc5MjAyMDg4ODJ9.Kuut9k7NMH-TPQQmV6YdjgmYyH7wlGR4ZQmB8x1WhTA&exchange=binance&symbol=#{pair}&interval=1d"
      end
      resp_st = Net::HTTP.get_response(URI.parse(url_st))
      data_st = JSON.parse(resp_st.body)

      valueAdvice = data_st["valueAdvice"]
      data_st.each do |i,hash|
        crypto_arr << hash
      end

      puts crypto_arr

      session = GoogleDrive::Session.from_service_account_key("client_secrets.json")
      spreadsheet = session.spreadsheet_by_title("Binance")
      worksheet = spreadsheet.worksheets[counter]
      advice_from_sheet = worksheet["B3"]

      puts advice_from_sheet
      #byebug

      if valueAdvice == "long" || valueAdvice == "short"
        if advice_from_sheet != valueAdvice
          puts "enviar correo"
          ApplicationMailer.supertrend_analyse(crypto_arr,pair).deliver
        end
      
        worksheet.insert_rows(3,
        [
          crypto_arr
        ])

        worksheet.save
      end
      crypto_arr.clear
      counter += 1
      sleep 20
    end   
  end

  task :mailbinance => :environment do
    
    crypto_pair = {"btc"=>"BTC/USDT"}
    crypto_arr = Array.new
    candle_open = 0
    candle_close = 0
    candle_high = 0
    candle_low = 0
    volume = 0

    crypto_pair.each do |crypto, pair|

      url_candle = "https://api.taapi.io/candle?secret=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imp1bGlvMzM2QGhvdG1haWwuY29tIiwiaWF0IjoxNjEzMDA4ODgyLCJleHAiOjc5MjAyMDg4ODJ9.Kuut9k7NMH-TPQQmV6YdjgmYyH7wlGR4ZQmB8x1WhTA&exchange=binance&symbol=#{pair}&interval=15m"
      resp_candle = Net::HTTP.get_response(URI.parse(url_candle))
      data_candle = JSON.parse(resp_candle.body)

      data_candle.each do |i,hash|
        if i == "open"
          candle_open = hash.to_f
        end

        if i == "high"
          candle_high = hash.to_f
        end

        if i == "low"
          candle_low = hash.to_f
        end
          
        if i == "close"
          candle_close = hash.to_f
        end
        
        if i == "volume"
          volume = hash.to_f
        end

        crypto_arr << hash
      
      end
      
    end

    procent = ((candle_close/candle_open) - 1)*100
    crypto_arr << procent.round(2)
    puts crypto_arr

    session = GoogleDrive::Session.from_service_account_key("client_secrets.json")

    spreadsheet = session.spreadsheet_by_title("Binance")
    worksheet = spreadsheet.worksheets.first
    worksheet.insert_rows(worksheet.num_rows + 1,
    [
      crypto_arr
    ])

    volume_from_sheet = worksheet["I2"].to_f
    high_from_sheet = worksheet["I5"].to_f
    low_from_sheet = worksheet["I8"].to_f

    puts volume_from_sheet
    puts volume

    if volume >= 700
      puts "Volumen mayor"
      ApplicationMailer.volume_analyse(volume_from_sheet, crypto_arr, volume).deliver
    end

    if candle_high >= high_from_sheet
      puts "send email"
      ApplicationMailer.long_analyse(volume_from_sheet, crypto_arr, volume).deliver
    end 

    if candle_low <= low_from_sheet
      puts "send email"
      ApplicationMailer.short_analyse(volume_from_sheet, crypto_arr, volume).deliver
    end 

    worksheet.save
  end

  task :rsi => [ :environment ] do
   # crypto_pair = {"btc"=>"BTC/USDT", "eth" => "ETH/USDT", "xrp" => "XRP/USDT", "ltc" => "LTC/USDT", "xmr" => "XMR/USDT"}
    crypto_pair = {"btc"=>"BTC/USDT", "eth" => "ETH/USDT", "sol" => "SOL/USDT", "avax" => "AVAX/USDT", "near" => "NEAR/USDT", "ltc" => "LTC/USDT", "mana" => "MANA/USDT", "xrp" => "XRP/USDT", "ada" => "ADA/USDT", "doge" => "DOGE/USDT", "dot" => "DOT/USDT"}
    crypto_arr = Hash.new
    crypto_pair.each do |crypto, pair|
      url_rsi = "https://api.taapi.io/rsi?secret=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imp1bGlvMzM2QGhvdG1haWwuY29tIiwiaWF0IjoxNjEzMDA4ODgyLCJleHAiOjc5MjAyMDg4ODJ9.Kuut9k7NMH-TPQQmV6YdjgmYyH7wlGR4ZQmB8x1WhTA&exchange=binance&symbol=#{pair}&interval=5m"
      resp_rsi = Net::HTTP.get_response(URI.parse(url_rsi))
      data_rsi = JSON.parse(resp_rsi.body)
      #puts pair
      #puts data_rsi
      if !data_rsi["value"].nil?
        #puts data_rsi["value"]
        if data_rsi["value"] < 25 || data_rsi["value"] > 75
          crypto_arr.store(pair, data_rsi)
          puts crypto_arr
          ApplicationMailer.rsi_email(crypto_arr).deliver
        end
      end
      sleep 20
    end
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

