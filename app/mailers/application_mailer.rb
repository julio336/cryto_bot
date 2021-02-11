
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def test_email(subject)
    to = "julio336@hotmail.com"
    mail(:to => to, :subject => subject, :from => "default_sender@foo.bar") do |format|
    	format.text(:content_type => "text/plain", :charset => "UTF-8", :content_transfer_encoding => "7bit")
		end			
    end
end
