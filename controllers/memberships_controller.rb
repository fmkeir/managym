require_relative('../models/membership')

get '/memberships' do
  @memberships = Membership.all()
  erb(:'memberships/index')
end

get '/memberships/new' do
  erb(:"memberships/new")
end

get '/memberships/:id' do
  @membership = Membership.find(params['id'])
  erb(:"memberships/show")
end

get '/memberships/:id/edit' do
  @membership = Membership.find(params['id'])
  erb(:"memberships/edit")
end

post '/memberships' do
  Membership.new(params).save()
  redirect to '/memberships'
end

post '/memberships/:id' do
  Membership.new(params).update()
  redirect to '/memberships'
end

post '/memberships/:id/delete' do
  Membership.find(params[:id]).delete()
  redirect to '/memberships'
end
