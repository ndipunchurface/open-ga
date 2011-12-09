class AmendmentsController < ApplicationController

  def index
    @amendments = Amendment.all
  end

  def show
    @amendment = Amendment.find(params[:id])
  end

  def new
    @amendment = Amendment.new
  end

  def create
    @amendment = Amendment.new(params[:amendment])

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
    @amendment.destroy
  end

end
