require_relative('../models/member')

get '/members' do
  @members = Member.all()
  erb(:'members/index')
end

get '/members/new' do
  erb(:"members/new")
end

get '/members/:id' do
  @member = Member.find(params['id'])
  erb(:"members/show")
end

get '/members/:id/edit' do
  @member = Member.find(params['id'])
  erb(:"members/edit")
end

post '/members' do
  Member.new(params).save()
  redirect to '/members'
end

post '/members/:id' do
  Member.new(params).update()
  redirect to '/members'
end
