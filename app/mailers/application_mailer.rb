class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def test_email()
		puts "Email enviado"
      	to = "julio336@hotmail.com"

	     mail(:to => to, :subject => "test email", :from => "default_sender@foo.bar") do |format|
        		format.text(:content_type => "text/plain", :charset => "UTF-8", :content_transfer_encoding => "7bit")
        end
    end
end
