class AssembliesController < ApplicationController
  skip_before_filter :authorize_participation
  
  def index
    authorizations = current_user.authorizations.collect { |a| a.assembly_uuid }
    @assemblies = Assembly.find(authorizations)
  end

  def show
    authorize_participation
    @assembly = Assembly.find_by_uuid_or_alias(params[:id])
    @proposals = @assembly.proposals
  end

  def create
    @assembly.new(params[:assembly])
    @assembly.user_id = current_user.id

    #write the rest
  end

end
