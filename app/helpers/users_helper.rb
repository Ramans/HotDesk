module UsersHelper

	def staff_desks
		seat_groups = ["A", "B", "C"]
		group_seat_size = 10

		desks = []

		seat_groups.each do |group|
			(1..group_seat_size).each do |i|
				desks << "#{group}#{i}"
			end
		end
		return desks
	end

end
