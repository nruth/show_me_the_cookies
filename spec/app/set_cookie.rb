require 'sinatra'

get '/' do
  "Cookie setter ready"
end

get '/set/:key/:value' do
  response.set_cookie params[:key], {:value => params[:value], :path => '/'}
  "Setting #{params[:key]}=#{params[:value]}"
end

get '/delete/:key' do
  response.delete_cookie params[:key], :path => '/'
  "Deleting #{params[:key]}"
end