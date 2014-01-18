Avignon::App.controllers :webservice do
# encoding: UTF-8

  get '/companies' do
    response.headers["Content-Type"] = "application/JSON; charset=utf-8"
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET"
    return Company.all.to_json(:include => :directors)
  end

  get '/directors/:id' do
    response.headers["Content-Type"] = "application/JSON; charset=utf-8"
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET"
    return get_director_json(params[:id]);

  end

  get '/companies/:id' do
    response.headers["Content-Type"] = "application/JSON; charset=utf-8"
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET"
    return get_company_json(params[:id])

  end

  post '/companies', :csrf_protection => false do
    response.headers["Content-Type"] = "application/JSON; charset=utf-8"
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "POST"
    request.body.rewind
    body = request.body.read && request.body.read.length >= 2 ? JSON.parse(request.body.read) : nil
    #if (body == nil)
    #body = JSON.parse('{"name":"Easyjet","address":"LBA Airport","city":"Leeds","country":"UK","email":"sales@lba.co.uk","phone":"01136998855"}')
    #end
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
    return Company.to_json(:include => :directors)

  end

  put '/companies/:id' do
    response.headers["Content-Type"] = "application/JSON; charset=utf-8"
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "PUT"
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
    return Company.to_json(:include => :directors)
  end

  delete '/companies/:id' do
    response.headers["Content-Type"] = "application/JSON; charset=utf-8"
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "DELETE"
    Company ||= Company.get(params[:id]) || halt(404)
    halt 500 unless Company.destroy
  end

end
