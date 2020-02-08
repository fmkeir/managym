require_relative('../models/session')

get '/sessions' do
  @sessions = Session.all()
  erb(:'sessions/index')
end

get '/sessions/new' do
  erb(:"sessions/new")
end

get '/sessions/:id' do
  @session = Session.find(params['id'].to_i)
  erb(:"sessions/show")
end

get '/sessions/:id/edit' do
  @session = Session.find(params['id'])
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
