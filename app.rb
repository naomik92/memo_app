require 'sinatra'
require 'sinatra/reloader'
require 'json'

get '/index' do
  @memos = memos
  erb :index
end

get '/new' do
  erb :new
end

get '/memo/:id' do
  @id = params[:id]
  @title = memos[params[:id].to_i - 1][:title]
  @detail = memos[params[:id].to_i - 1][:detail]
  erb :show
end

get '/memo/:id/edit' do
  @title = memos[params[:id].to_i - 1][:title]
  @detail = memos[params[:id].to_i - 1][:detail]  
  erb :edit
end

def memos
  File.open('memo_data.json') do |file|
    JSON.parse(file.read, symbolize_names: true)
  end
end
