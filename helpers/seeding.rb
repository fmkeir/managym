def random_booking(members, sessions, max_member_bookings)
  number_of_sessions = sessions.count()
  for member in members
    member_bookings = rand((number_of_sessions/3)..max_member_bookings)
    bookings_made = 0
    attempts = 0
    until bookings_made == member_bookings || attempts >= number_of_sessions
      if Booking.create(member, sessions.sample()) == "Done"
        bookings_made += 1
      end
      attempts += 1
    end
  end
end
