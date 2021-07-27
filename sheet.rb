require 'bundler'
require "net/http"
require "google/api_client/client_secrets"

Bundler.require

crypto_pair = {"btc"=>"BTC/USDT"}
crypto_arr = Array.new
candle_open = 0
candle_close = 0

crypto_pair.each do |crypto, pair|
	url_candle = "https://api.taapi.io/candle?secret=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imp1bGlvMzM2QGhvdG1haWwuY29tIiwiaWF0IjoxNjEzMDA4ODgyLCJleHAiOjc5MjAyMDg4ODJ9.Kuut9k7NMH-TPQQmV6YdjgmYyH7wlGR4ZQmB8x1WhTA&exchange=binance&symbol=#{pair}&interval=15m"
	resp_candle = Net::HTTP.get_response(URI.parse(url_candle))
    data_candle = JSON.parse(resp_candle.body)

    data_candle.each do |i,hash|
    	if i == "open"
    		candle_open = hash.to_f
    	end
    	
    	if i == "close"
    		candle_close = hash.to_f
    	end
		crypto_arr << hash
	
	end
	
end

procent = ((candle_close/candle_open) - 1)*100
crypto_arr << procent
puts crypto_arr

session = GoogleDrive::Session.from_service_account_key("client_secrets.json")

spreadsheet = session.spreadsheet_by_title("Binance")
worksheet = spreadsheet.worksheets.first
worksheet.insert_rows(worksheet.num_rows + 1,
[
	crypto_arr
])
worksheet.save

