require 'sinatra'
require 'sinatra/reloader'

get '/index' do
  erb :index
end

get '/new' do
  erb :new
end

get '/memo' do
  erb :show
end

get '/edit' do
  erb :edit
end
