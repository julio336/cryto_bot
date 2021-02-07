class UserMailer < ApplicationMailer
	default from: 'notifications@example.com'

 	def index
 		logger.debug("test")
  	end
end
