require('sinatra')
require('sinatra/contrib/all')
require_relative('controllers/members_controller')
require_relative('controllers/sessions_controller')
require_relative('controllers/bookings_controller')
require_relative('controllers/memberships_controller')
require_relative('controllers/rooms_controller')
also_reload('models/*')

get '/' do
  @member_count = Member.count()
  @booking_count = Booking.count()
  @session_count = Session.count()
  @room_count = Room.count()
  erb(:index)
end

error 404 do
  @message = "404: We couldn't find that page!"
  erb(:error)
end
