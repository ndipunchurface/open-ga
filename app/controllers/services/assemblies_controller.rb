class Services::AssembliesController < Services::ApplicationController
  def index
    render :json => invalid_action
  end
end
