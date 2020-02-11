require_relative('../models/member')
require_relative('../models/membership')

get '/members' do
  @members = Member.all()
  erb(:'members/index')
end

get '/members/new' do
  @memberships = Membership.all()
  erb(:"members/new")
end

get '/members/:id' do
  @member = Member.find(params['id'])
  erb(:"members/show")
end

get '/members/:id/edit' do
  @member = Member.find(params['id'])
  @memberships = Membership.all()
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

post '/members/:id/delete' do
  Member.find(params[:id]).delete()
  redirect to '/members'
end
