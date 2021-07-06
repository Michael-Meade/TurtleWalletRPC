require 'sinatra'
require 'json'
require "rqrcode"
require_relative '../module_example'
set :public_folder, __dir__ + '/public'
get '/' do 
    erb :index 
end
get '/address' do
    erb :index
end