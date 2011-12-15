class AmendmentsController < ApplicationController

  def index
    @amendments = Amendment.all
  end

  def show
    @amendment = @proposal.amendments.find(params[:id])
  end

  def new
    @amendment = @proposal.amendments.build
  end

  def create
    @amendment = @proposal.amendments.build(params[:amendment])

    if @amendment.save
      flash[:success] = t('amendments.create.success')
      redirect_to assembly_proposal_amendment_url(@assembly,@proposal, @amendment)
    else
      render :new
    end
  end

  def edit
    @amendment = Amendment.find(params[:id])
    authenticate_ownership(@amendment)
  end

  def update
    @amendment = Amendment.find(params[:id])
    authenticate_ownership(@amendment)

    @amendment.title = params[:amendment][:title]
    @amendment.body = params[:amendment][:body]

    if @amendment.save
      flash[:success] = t('amendments.update.success')
      redirect_to assembly_proposal_amendment_url(@assembly,@proposal,@amendment)
    else
      render :new
    end
  end

  def destroy
    @amendment = Amendment.find(params[:id])
    authenticate_ownership(@amendment)
    if @amendment.destroy
      flash[:notice] = t('amendments.destroy.success')
      redirect_to assembly_proposal_path(@assembly,@proposal)
    else
      flash[:error] = t('amendments.destroy.error')
      redirect_to assembly_proposal_path(@assembly,@propsal,@amendment)
    end
  end

end
