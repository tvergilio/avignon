Avignon::App.controllers :webservice do


# encoding: UTF-8

  get '/companies' do
    response.headers["Content-Type"] = "application/JSON; charset=utf-8"
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE"
    return ::Company.all.to_json(:include => :directors)
  end

  get '/directors/:id' do
    response.headers["Content-Type"] = "application/JSON; charset=utf-8"
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE"
    return get_director_json(params[:id]);

  end

  get '/companies/:id' do
    response.headers["Content-Type"] = "application/JSON; charset=utf-8"
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE"
    return get_company_json(params[:id])

  end

  post '/companies', :csrf_protection => false do
    response.headers["Content-Type"] = "application/JSON; charset=utf-8"
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE"
    request.body.rewind
    body = JSON.parse(request.body.read)
    theCompany = Company.new({
                              :name => body['name'],
                              :address => body['address'],
                              :city => body['city'],
                              :country => body['country'],
                              :email => body['email'],
                              :phone => body['phone']
                          })

      theCompany.save!
      status 201
      return theCompany.to_json(:include => :directors)

  end

  put '/companies/:id' do
    response.headers["Content-Type"] = "application/JSON; charset=utf-8"
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE"
    request.body.rewind
    body = JSON.parse request.body.read
    Company ||= Company.get(params[:id]) || halt(404)
    return Company.errors.full_messages unless Company.update(params[:id], {
        :name => body['name'],
        :address => body['address'],
        :city => body['city'],
        :country => body['country'],
        :email => body['email'],
        :phone => body['phone']
    })

  end

  delete '/companies/:id' do
    response.headers["Content-Type"] = "application/JSON; charset=utf-8"
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE"
    request.body.rewind
    Company ||= Company.get(params[:id]) || halt(404)
    halt 500 unless Company.destroy(params[:id])
    status 200
  end

end
