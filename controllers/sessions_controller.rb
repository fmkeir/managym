require_relative('../models/session')

get '/sessions' do
  @sessions = Session.all()
  erb(:'sessions/index')
end

get '/sessions/:id' do
  @session = Session.find(params['id'].to_i)
  erb(:"sessions/show")
end
