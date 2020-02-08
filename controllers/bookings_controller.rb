require_relative('../models/booking')

get "/bookings" do
  @bookings = Booking.all()
  erb(:"bookings/index")
end

get '/bookings/new' do
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
