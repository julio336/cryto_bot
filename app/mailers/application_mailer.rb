require "net/http"

class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def test_email()
		puts "Email enviado"
      	to = "julio336@hotmail.com"
      	url = "https://api.taapi.io/rsi?secret=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imp1bGlvMzM2QGhvdG1haWwuY29tIiwiaWF0IjoxNjEyOTI4MzUyLCJleHAiOjc5MjAxMjgzNTJ9.zIZbSk9qMs6-P9OMGyS_c2kO2vdxWIXio6c3nrYh6UE
				&exchange=binance&symbol=BTC/USDT&interval=15m"
		resp = Net::HTTP.get_response(URI.parse(url))
		data = JSON.parse(resp.body)
		puts data
	    mail(:to => to, :subject => data, :from => "default_sender@foo.bar") do |format|
        		format.text(:content_type => "text/plain", :charset => "UTF-8", :content_transfer_encoding => "7bit")
        end
    end
end
