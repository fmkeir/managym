require_relative('../models/session')

get '/sessions' do
  @sessions = Session.all()
  erb(:'sessions/index')
end
