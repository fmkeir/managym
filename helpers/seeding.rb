def random_booking(members, sessions, number_of_bookings)
  bookings_made = 0
  until bookings_made == number_of_bookings
    if Booking.create(members.sample(), sessions.sample()) == "Done"
      bookings_made += 1
    end
  end
end
