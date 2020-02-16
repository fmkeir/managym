def random_booking(members, sessions)
  Booking.create(members.sample(), sessions.sample())
end
