Avignon::Admin.controllers :directors do
  get :index do
    @title = "Directors"
    @directors = Director.all
    render 'directors/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'director')
    @director = Director.new
    render 'directors/new'
  end

  post :create do
    @director = Director.new(params[:director])
    if @director.save
      @title = pat(:create_title, :model => "director #{@director.id}")
      flash[:success] = pat(:create_success, :model => 'Director')
      params[:save_and_continue] ? redirect(url(:directors, :index)) : redirect(url(:directors, :edit, :id => @director.id))
    else
      @title = pat(:create_title, :model => 'director')
      flash.now[:error] = pat(:create_error, :model => 'director')
      render 'directors/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "director #{params[:id]}")
    @director = Director.find(params[:id])
    if @director
      render 'directors/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'director', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "director #{params[:id]}")
    @director = Director.find(params[:id])
    if @director
      if @director.update_attributes(params[:director])
        flash[:success] = pat(:update_success, :model => 'Director', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:directors, :index)) :
          redirect(url(:directors, :edit, :id => @director.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'director')
        render 'directors/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'director', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Directors"
    director = Director.find(params[:id])
    if director
      if director.destroy
        flash[:success] = pat(:delete_success, :model => 'Director', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'director')
      end
      redirect url(:directors, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'director', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Directors"
    unless params[:director_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'director')
      redirect(url(:directors, :index))
    end
    ids = params[:director_ids].split(',').map(&:strip)
    directors = Director.find(ids)
    
    if Director.destroy directors
    
      flash[:success] = pat(:destroy_many_success, :model => 'Directors', :ids => "#{ids.to_sentence}")
    end
    redirect url(:directors, :index)
  end
end
