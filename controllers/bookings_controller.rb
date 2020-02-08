require_relative('../models/booking')

get "/bookings" do
  @bookings = Booking.all()
  erb(:"bookings/index")
end
