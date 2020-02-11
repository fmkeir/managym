require_relative('../models/room')

get '/rooms' do
  @rooms = Room.all()
  erb(:'rooms/index')
end

get '/rooms/new' do
  erb(:"rooms/new")
end

get '/rooms/:id' do
  @room = Room.find(params['id'])
  erb(:"rooms/show")
end

get '/rooms/:id/edit' do
  @room = Room.find(params['id'])
  erb(:"rooms/edit")
end

post '/rooms' do
  Room.new(params).save()
  redirect to '/rooms'
end

post '/rooms/:id' do
  Room.new(params).update()
  redirect to '/rooms'
end

post '/rooms/:id/delete' do
  Room.find(params[:id]).delete()
  redirect to '/rooms'
end
