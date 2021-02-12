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
    crypto_pair = {"btc" => "BTC/USDT", "eth" => "ETH/USDT", "xrp" => "XRP/USDT", "ltc" => "LTC/USDT",
                 "xmr" => "XMR/USDT"}
        
    crypto_pair.each do |crypto, pair|
      url = "https://api.taapi.io/rsi?secret=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imp1bGlvMzM2QGhvdG1haWwuY29tIiwiaWF0IjoxNjEzMDA4ODgyLCJleHAiOjc5MjAyMDg4ODJ9.Kuut9k7NMH-TPQQmV6YdjgmYyH7wlGR4ZQmB8x1WhTA&exchange=binance&symbol=#{pair}&interval=15m"
      resp = Net::HTTP.get_response(URI.parse(url))
      data = JSON.parse(resp.body)
      if data['value'] <= 35 || data['value'] > 70
        puts "Email enviado"
        subject = "#{pair}: #{data['value']}"
        puts subject
        ApplicationMailer.test_email(subject).deliver
      else
        puts data
      end
    end
  end
end

