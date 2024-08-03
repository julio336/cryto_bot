
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

	def test_email()
    	to = "julio.ahuactzin@gmail.com"
    	mail(:to => to, :subject => "Señal COMPRA/VENTA", :from => "CRYPTO BOT") do |format|
    		format.text(:content_type => "text/plain", :charset => "UTF-8", :content_transfer_encoding => "7bit")
		end			
    end

    def rsi_sobreventa_email(arr)
        @arr_crypto = arr
    	to = "julio.ahuactzin@gmail.com"
    	mail(:to => to, :subject => "Señal Sobreventa RSI", :from => "CRYPTO BOT RSI") do |format|
    		format.text(:content_type => "text/plain", :charset => "UTF-8", :content_transfer_encoding => "7bit")
		end			
    end

    def rsi_email(arr)
        @arr_crypto = arr
    	to = "julio.ahuactzin@gmail.com"
    	mail(:to => to, :subject => "Señal RSI", :from => "CRYPTO BOT RSI") do |format|
    		format.text(:content_type => "text/plain", :charset => "UTF-8", :content_transfer_encoding => "7bit")
		end			
    end


    def macd(value)
        @value = value
    	to = "julio.ahuactzin@gmail.com"
    	mail(:to => to, :subject => "MACD Histogram Signal", :from => "CRYPTO BOT") do |format|
    		format.text(:content_type => "text/plain", :charset => "UTF-8", :content_transfer_encoding => "7bit")
		end			
    end

    def rsi_sobrecompra_email(arr)
        @arr_crypto = arr
    	to = "julio.ahuactzin@gmail.com"
    	mail(:to => to, :subject => "Señal Sobrecompra RSI", :from => "CRYPTO BOT RSI") do |format|
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

    def supertrend_analyse(arr,pair)
        to = "julio.ahuactzin@gmail.com"
        @arr_crypto = arr
        @pair = pair
        mail(:to => to, :subject => "Señal Super Trend", :from => "CRYPTO BOT") do |format|
            format.text(:content_type => "text/plain", :charset => "UTF-8", :content_transfer_encoding => "7bit")
        end         
    end



    def long_analyse(volume_from_sheet, arr, volume)
        to = "julio.ahuactzin@gmail.com"
        @arr_crypto = arr
        @volume_from_sheet = volume_from_sheet
        @volume = volume
        mail(:to => to, :subject => "LONG BTC/USDT", :from => "CRYPTO BOT") do |format|
            format.text(:content_type => "text/plain", :charset => "UTF-8", :content_transfer_encoding => "7bit")
        end         
    end

    def short_analyse(volume_from_sheet, arr, volume)
        to = "julio.ahuactzin@gmail.com"
        @arr_crypto = arr
        @volume_from_sheet = volume_from_sheet
        @volume = volume
        mail(:to => to, :subject => "SHORT BTC/USDT", :from => "CRYPTO BOT") do |format|
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
