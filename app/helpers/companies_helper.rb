# Helper methods defined here can be accessed in any controller or view in the application

Avignon::App.helpers do
  def format_response(data, accept)
	accept.each do |type|
		return data.to_json if type.downcase.eql? 'application/json'
		return data.to_xml if type.downcase.eql? 'text/xml'
		return data.to_yaml if type.downcase.eql? 'text/x-yaml'
		return data.to_csv if type.downcase.eql? 'text/csv'
		return data.to_json
	end
  end

  def edit
    @company = Company.find(params[:id])
  end
  
end
