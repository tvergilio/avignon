Avignon::App.controllers :webservice do
# encoding: UTF-8
	
get '/companies' do
  format_response(Company.all, request.accept)
end

get '/companies/:id' do
  Company ||= Company.get(params[:id]) || halt(404)
  format_response(Company, request.accept)
end

post '/companies', :csrf_protection => false do
request.body.rewind
  body = request.body.read && request.body.read.length >= 2 ? JSON.parse(request.body.read) : nil
  if (body == nil)
	body = JSON.parse('{"name":"Easyjet","address":"LBA Airport","city":"Leeds","country":"UK","email":"sales@lba.co.uk","phone":"01136998855"}') 
  end
  Company = Company.new(
    :name  =>  body['name'],
    :address  => body['address'],
	  :city  => body['city'],
	  :country  => body['country'],
	  :email  => body['email'],
	  :phone  => body['phone']
  )
  
  Company.save!
  status 201  
  format_response(Company, request.accept)
    
  
end

put '/companies/:id' do
  body = JSON.parse request.body.read
  Company ||= Company.get(params[:id]) || halt(404)
  halp 500 unless Company.update(
    name:    body['name'],
    address: body['address'],
	:city  => body['city'],
	:country  => body['country'],
	:email  => body['email'],
	:phone  => body['phone']
  )
  format_response(Company, request.accept)
end

delete '/companies/:id' do
  Company ||= Company.get(params[:id]) || halt(404)
  halt 500 unless Company.destroy
end 

end
