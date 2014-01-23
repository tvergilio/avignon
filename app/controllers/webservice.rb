Avignon::App.controllers :webservice do


# encoding: UTF-8

  get '/csrf_token', :provides => :json do
    logger.debug 'Retrieving csrf_token'
    result = {
        :csrf => session[:csrf]
    }
    JSON.pretty_generate result
  end

  get '/companies' do
    response.headers["Content-Type"] = "application/JSON; charset=utf-8"
    response.headers["Access-Control-Allow-Origin"] = ["http://localhost:8000", "http://monaco-ancient-beach.herokuapp.com"]
    response.headers["Access-Control-Allow-Methods"] = "GET"
    return Company.all.to_json(:include => :directors)
  end

  get '/directors/:id' do
    return get_director_json(params[:id]);
  end

  post '/directors', :csrf_protection => false do
    response.headers["Content-Type"] = "application/JSON; charset=utf-8"
    response.headers["Access-Control-Allow-Origin"] = ["http://localhost:8000", "http://monaco-ancient-beach.herokuapp.com"]
    response.headers["Access-Control-Allow-Methods"] = "POST"
    request.body.rewind
    body = JSON.parse(request.body.read)

    theDirector = Director.new({
                                   :forename => body['forename'],
                                   :surname => body['surname'],
                                   :company_id => body['company_id']
                               })
    theDirector.save!
    status 201
    return theDirector.to_json(:include => :documents)

  end

  get '/companies/:id' do
    return get_company_json(params[:id])
  end


  post '/companies/', :csrf_protection => false do
    response.headers["Content-Type"] = "application/JSON; charset=utf-8"
    response.headers["Access-Control-Allow-Origin"] = ["http://localhost:8000", "http://monaco-ancient-beach.herokuapp.com"]
    response.headers["Access-Control-Allow-Methods"] = "POST"
    request.body.rewind
    body = request.body.read
    bodyEnd = body.index('&authenticity_token');
    trimmedBody = ''
    if bodyEnd > 0
      trimmedBody = body[0, bodyEnd]
    end
    trimmedBody = JSON.parse(trimmedBody)
    theCompany = Company.new({
                                 :name => trimmedBody['name'],
                                 :address => trimmedBody['address'],
                                 :city => trimmedBody['city'],
                                 :country => trimmedBody['country'],
                                 :email => trimmedBody['email'],
                                 :phone => trimmedBody['phone']
                             })

    theCompany.save!
    status 201
    return theCompany.to_json(:include => :directors)

  end

  put '/companies/:id', :csrf_protection => false do
    response.headers["Content-Type"] = "application/JSON; charset=utf-8"
    response.headers["Access-Control-Allow-Origin"] = ["http://localhost:8000", "http://monaco-ancient-beach.herokuapp.com"]
    response.headers["Access-Control-Allow-Methods"] = "PUT"
    request.body.rewind
    body = request.body.read
    bodyEnd = body.index('&authenticity_token');
    trimmedBody = ''
    if bodyEnd > 0
      trimmedBody = body[0, bodyEnd]
    end
    trimmedBody = JSON.parse(trimmedBody)

    #theCompany = Company.find(params[:id])
    return Company.update(params[:id], {
        #:name => trimmedBody['name'],
        :address => trimmedBody['address'],
        :city => trimmedBody['city'],
        :country => trimmedBody['country'],
        :email => trimmedBody['email'],
        :phone => trimmedBody['phone']
    })

  end

  delete '/companies/:id' do
    response.headers["Content-Type"] = "application/JSON; charset=utf-8"
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "DELETE"
    request.body.rewind
    Company ||= Company.get(params[:id]) || halt(404)
    halt 500 unless Company.destroy(params[:id])
    status 200
  end

  delete '/directors/:id' do
    response.headers["Content-Type"] = "application/JSON; charset=utf-8"
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "DELETE"
    request.body.rewind
    Director ||= Director.get(params[:id]) || halt(404)
    halt 500 unless Director.destroy(params[:id])
    status 200
  end

  post '/directors/:id/document', :csrf_protection => false do
    response.headers["Content-Type"] = "application/JSON; charset=utf-8"
    response.headers["Access-Control-Allow-Origin"] = ["http://localhost:8000", "http://monaco-ancient-beach.herokuapp.com"]
    response.headers["Access-Control-Allow-Methods"] = "POST"

    #upload
    unless params[:file] &&
        (tmpfile = params[:file][:tempfile]) &&
        (name = params[:file][:filename])
      @error = "No file selected"
    end
    STDERR.puts "Uploading file, original name " + params[:file][:filename]
    directory = "public/files"
    path = File.join(directory, params[:file][:filename])
    while blk = tmpfile.read(65536)
      File.open(path, "wb") { |f| f.write(tmpfile.read) }
      STDERR.puts blk.inspect
    end

    #create Document (database record)
    theDocument = Document.new({
                                   :director_id => params[:id],
                                   :name => params[:file][:filename]
                               })
    theDocument.save!
    status 201
    return theDocument.to_json
  end
end
