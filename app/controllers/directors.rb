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
    render 'directors/show'
  end

end
