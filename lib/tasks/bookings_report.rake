namespace :users do

    desc "Send bookings report."
    task :bookings_report => :environment do |t, args|
        
        @users = User.where(booking_date: Date.today.all_day)

        @admin_emails = User.select("email").where(:user_type => "admin").pluck(:email)

        if @users.present?
            @users.each do |user|
                puts "#{Time.now}: #{user.email}"
            end
            UserMailer.bookings_report(@users, @admin_emails).deliver
        else
            puts "#{Time.now}: No booking are there today"
        end
        
    end

end
