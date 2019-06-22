class UserMailer < ApplicationMailer

	default from: "arudra.raman@gmail.com"

	def bookings_report(users, admin_emails)
	    @users = users
	    mail(to: admin_emails, subject: 'Staff seat booking report')
	end

end
