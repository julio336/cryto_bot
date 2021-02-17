
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

	def test_email(arr)
    	to = "julio336@hotmail.com"
    	@arr_crypto = arr
    	mail(:to => to, :subject => "Señal COMPRA/VENTA", :from => "CRYPTO BOT") do |format|
    		format.text(:content_type => "text/plain", :charset => "UTF-8", :content_transfer_encoding => "7bit")
		end			
    end

 	def senal_venta()
    	to = "julio336@hotmail.com"
    	mail(:to => to, :subject => "Señal VENTA", :from => "CRYPTO BOT") do |format|
    		format.text(:content_type => "text/plain", :charset => "UTF-8", :content_transfer_encoding => "7bit")
		end			
    end
    def senal_compra()
    	to = "julio336@hotmail.com"
    	mail(:to => to, :subject => "Señal COMPRA", :from => "CRYPTO BOT") do |format|
    		format.text(:content_type => "text/plain", :charset => "UTF-8", :content_transfer_encoding => "7bit")
		end			
    end
end
