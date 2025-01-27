# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'securerandom'

get '/memos' do
  @memos = find_memos
  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  title = params[:title]
  detail = params[:detail]
  add_memo(title, detail)
  redirect '/memos'
end

get '/memos/:id' do
  memos = find_memos
  idx = memos.find_index do |hash|
    hash[:id] == params[:id]
  end
  @id = params[:id]
  @title = memos[idx][:title]
  @detail = memos[idx][:detail]
  erb :show
end

get '/memos/:id/edit' do
  memos = find_memos
  idx = memos.find_index do |hash|
    hash[:id] == params[:id]
  end
  @id = params[:id]
  @title = memos[idx][:title]
  @detail = memos[idx][:detail]
  erb :edit
end

patch '/memos/:id' do
  memos = find_memos
  idx = memos.find_index do |hash|
    hash[:id] == params[:id]
  end
  memos[idx][:title] = params[:title]
  memos[idx][:detail] = params[:detail]
  File.open('memo_data.json', 'w') do |file|
    JSON.dump(memos, file)
  end
  redirect '/memos'
end

delete '/memos/:id' do
  memos = find_memos
  memos.delete_if { |hash| hash[:id] == params[:id] }
  File.open('memo_data.json', 'w') do |file|
    JSON.dump(memos, file)
  end
  redirect '/memos'
end

def find_memos
  File.open('memo_data.json') do |file|
    JSON.parse(file.read, symbolize_names: true)
  end
end

def add_memo(title, detail)
  memos = find_memos
  memos << { id: SecureRandom.uuid, title: title, detail: detail }
  File.open('memo_data.json', 'w') do |file|
    JSON.dump(memos, file)
  end
end

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end
