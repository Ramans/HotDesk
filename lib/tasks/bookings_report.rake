namespace :users do

    desc "Maintenance Account Reset password"
    task :bookings_report => :environment do |t, args|
        
        @users = User.where(booking_date: Date.today.all_day)

        if @users.present?
            @users.each do |user|
                puts "#{Time.now}: #{user.email}"
            end
            UserMailer.bookings_report(@users).deliver
        else
            puts "#{Time.now}: No booking are there today"
        end
        
    end

end
