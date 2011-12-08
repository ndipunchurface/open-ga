class AssembliesController < ApplicationController
  skip_before_filter :authorize_participation
  
  def index
    authorizations = current_user.authorizations.collect { |a| a.assembly_uuid }
    @assemblies = Assembly.find(authorizations)
  end

  def show
    authorize_participation
    @assembly = Assembly.find(params[:id])
    @proposals = @assembly.proposals
  end

end
