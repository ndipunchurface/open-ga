class AssembliesController < ApplicationController
  def index
    @assembly = Assembly.find(current_user.assembly_id)
    redirect_to assembly_path(@assembly)
  end

  def show
    @assembly = Assembly.find_by_uuid(params[:id])
    @proposals = @assembly.proposals
  end
end
