require('sinatra')
# require('uri')
require_relative('./main.rb')
# configure(:production) do
#   uri = URI.parse(ENV["DATABASE_URL"])
#   set :database_config, {
#     host: uri.host,
#     dbname: uri.path[1..-1],
#     user: uri.user,
#     password: uri.password
#     }
# end
# configure(:development) do
#   p ENV['RACK_ENV']
#   set :database_config, {host: "localhost", dbname: "gym"}
# end
run Sinatra::Application
