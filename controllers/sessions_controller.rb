require_relative('../models/session')
require_relative('../models/room')

get '/sessions' do
  @sessions = Session.all()
  erb(:'sessions/index')
end

get '/sessions/new' do
  @rooms = Room.all()
  erb(:"sessions/new")
end

get '/sessions/:id' do
  @session = Session.find(params['id'].to_i)
  erb(:"sessions/show")
end

get '/sessions/:id/edit' do
  @session = Session.find(params['id'])
  @rooms = Room.all()
  erb(:"sessions/edit")
end

post '/sessions' do
  Session.new(params).save()
  redirect to '/sessions'
end

post '/sessions/:id' do
  Session.new(params).update()
  redirect to '/sessions'
end

post '/sessions/:id/delete' do
  Session.find(params[:id]).delete()
  redirect to '/sessions'
end
