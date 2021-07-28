
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

	def test_email(arr, price)
    	to = "julio.ahuactzin@gmail.com"
    	@arr_crypto = arr
    	@price = price
    	mail(:to => to, :subject => "Señal COMPRA/VENTA", :from => "CRYPTO BOT") do |format|
    		format.text(:content_type => "text/plain", :charset => "UTF-8", :content_transfer_encoding => "7bit")
		end			
    end


    def volume_analyse(volume_from_sheet, arr, volume)
        to = "julio.ahuactzin@gmail.com"
        @arr_crypto = arr
        @volume_from_sheet = volume_from_sheet
        @volume = volume
        mail(:to => to, :subject => "Señal COMPRA/VENTA", :from => "CRYPTO BOT") do |format|
            format.text(:content_type => "text/plain", :charset => "UTF-8", :content_transfer_encoding => "7bit")
        end         
    end


 	def senal_venta(pair, data_macd, venta)
    	to = "julio336@hotmail.com"
    	@macd = data_macd
    	@venta = venta
    	mail(:to => to, :subject => "Señal VENTA #{pair}", :from => "CRYPTO BOT") do |format|
    		format.text(:content_type => "text/plain", :charset => "UTF-8", :content_transfer_encoding => "7bit")
		end			
    end
    def senal_compra(pair, data_macd, compra)
    	to = "julio336@hotmail.com"
    	@macd = data_macd
    	@compra = compra
    	mail(:to => to, :subject => "Señal COMPRA #{pair}", :from => "CRYPTO BOT") do |format|
    		format.text(:content_type => "text/plain", :charset => "UTF-8", :content_transfer_encoding => "7bit")
		end			
    end
end
