def random_booking(members, sessions)
  booking = ''
  booking_attempts = 0
  until booking == "done" || booking_attempts == 4
    booking = Booking.create(members.sample(), sessions.sample())
    booking_attempts += 1
  end
end
