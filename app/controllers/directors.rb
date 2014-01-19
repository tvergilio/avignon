Avignon::App.controllers :directors do
  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  get '/example' do
    render 'directors/_form.html'
  end
  
  get :index do
  @directors = Director.all(:order => 'created_at desc')
  render 'directors/index'
  end

	get :show, :with => :id do
    @director = Director.find_by_id(params[:id])
    @company = Company.find(@director.company_id)
    render 'directors/show'
  end
  
  get '/attach' do
    response.headers["Content-Type"] = "application/JSON; charset=utf-8"
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE"
  render 'directors/upload' 
  end
  
  post '/upload', :csrf_protection => false do
    response.headers["Content-Type"] = "application/JSON; charset=utf-8"
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE"
  unless params[:file] &&
           (tmpfile = params[:file][:tempfile]) &&
           (name = params[:file][:filename])
      @error = "No file selected"
      return haml(:upload)
		end
      directory = "public/files"
      path = File.join(directory, name)
      File.open(path, "wb") { |f| f.write(tmpfile.read) }
end

end
