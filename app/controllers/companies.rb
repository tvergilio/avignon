Avignon::App.controllers :companies do
  
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
  
  get :index do
	@companies = Company.all(:order => 'name')
    render 'companies/index'

  end

  get :show, :with => :id do
  @company = Company.find_by_id(params[:id])
    render 'companies/show'

  end
  
  get :new do
  redirect('admin/companies/new')
  end
  
  get :edit, :with => :id do
  redirect('admin/companies/edit/#{:id}')
  end

end
