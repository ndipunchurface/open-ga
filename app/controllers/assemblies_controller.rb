class AssembliesController < ApplicationController
  skip_before_filter :authorize_participation, :only => [:index]
  
  def index
    authorizations = current_user.authorizations.collect { |a| a.assembly_uuid }
    ownerships = current_user.ownerships.collect { |a| a.assemblu_uuid }
    
    @authorized = Assembly.find(authorizations)
    @owned = Assembly.find(ownerships)
  end

  def show
    authorize_participation
    @assembly = Assembly.find_by_uuid_or_alias(params[:id])
    @proposals = @assembly.proposals
  end

  def new
    @assembly = Assembly.new
  end

  def create
    @assembly = current_user.assemblies.new(params[:assembly])

    if @assembly.save!
      flash[:success] = t('assemblies.create.success', :assembly_title => @assembly.name)
      redirect_to assembly_path(@assembly)
    else
      render :new
    end
  end

  def edit
    @assembly = Assembly.find_by_uuid_or_alias(params[:id])
    authenticate_ownership(@assembly)
  end

  def update
    @assembly = Assembly.find_by_uuid_or_alias(params[:id])
    authenticate_ownership(@assembly)

    if @assembly.save!
      flash[:success] = t('assemblies.update.success', :assembly_title => @assembly.name)
      redirect_to assembly_path(@assembly)
    else
      render :edit
    end
  end

end
