require 'sinatra'

get '/' do
  "Cookie setter ready"
end

get '/:key/:value' do
  response.set_cookie params[:key], params[:value]
  "Setting #{params[:key]}=#{params[:value]}"
end
