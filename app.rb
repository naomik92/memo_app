# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'securerandom'
require 'pg'

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
  connection.exec_params('UPDATE memo_data SET title = $2, detail = $3 WHERE id = $1', [params[:id], params[:title], params[:detail]])
  redirect '/memos'
end

delete '/memos/:id' do
  connection.exec_params('DELETE FROM memo_data WHERE id = $1', [params[:id]])
  redirect '/memos'
end

def connection
  PG::Connection.new(dbname: 'memo_app')
end

def find_memos
  results = connection.exec('SELECT * FROM memo_data ORDER BY created_at ASC')
  results.map { |result| result.transform_keys(&:to_sym) }
end

def add_memo(title, detail)
  id = SecureRandom.uuid
  connection.exec_params('INSERT INTO memo_data (id, title, detail) values ($1, $2, $3)', [id, title, detail])
end

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end
