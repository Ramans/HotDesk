class UserMailer < ApplicationMailer

	default from: "ramans0810@gmail.com"

	def bookings_report(users)
	    @users = users
	    mail(to: "arudra.raman@gmail.com", subject: 'Staff seat booking report')
	end

end
