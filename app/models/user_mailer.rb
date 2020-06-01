class UserMailer < ActionMailer::Base
	
	def sending_mail(user)
		@user = user
		@email = user.email
        @to= user.email
        @subject ="Welcome to My Awesome Site"
	end 

	def appointment_mail(appointment)
		recipients ="kavikalai109@gmail.com"
        bcc=        "haathim5653@gmail.com"
        from=       "kavikalai110@gmail.com"
        subject=    "New account information"
        content_type = "text/html"
	end
 

end
