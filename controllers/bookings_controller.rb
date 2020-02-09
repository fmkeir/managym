require_relative('../models/booking')
require_relative('../models/member')
require_relative('../models/session')

get "/bookings" do
  @bookings = Booking.all()
  erb(:"bookings/index")
end

get '/bookings/new' do
  @members = Member.all()
  @sessions = Session.all()
  erb(:"bookings/new")
end

get "/bookings/:id" do
  @booking = Booking.find(params["id"])
  erb(:"bookings/show")
end

post '/bookings' do
  Booking.new(params).save()
  redirect to '/bookings'
end

post "/bookings/:id/delete" do
  Booking.find(params[:id]).delete()
  redirect to "/bookings"
end
