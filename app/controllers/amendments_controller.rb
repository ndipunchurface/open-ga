class AmendmentsController < ApplicationController

  respond_to :html, :json

  def index
    @amendments = Amendment.all

    respond_to do |format|
      format.html
      format.json { render :text => @amendments.to_json }
    end
  end

  def show
    @amendment = @proposal.amendments.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :text => @amendment.to_json }
    end
  end

  def new
    @amendment = @proposal.amendments.build

    respond_to do |format|
      format.html
      format.json { render :text => @amendment.to_json }
    end
  end

  def create
    @amendment = @proposal.amendments.build(params[:amendment])

    if @amendment.save
      flash[:success] = t('amendments.create.success')

      respond_to do |format|
        format.html { redirect_to assembly_proposal_amendment_url(@assembly,@proposal, @amendment) }
        format.json { render :text => @amendment.to_json }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render :text => @amendment.to_json }
      end
    end
  end

  def edit
    @amendment = Amendment.find(params[:id])
    authenticate_ownership(@amendment) and return

    respond_to do |format|
      format.html
      format.json { render :text => @amendment.to_json }
    end
  end

  def update
    @amendment = Amendment.find(params[:id])
    authenticate_ownership(@amendment) and return

    @amendment.title = params[:amendment][:title]
    @amendment.body = params[:amendment][:body]

    if @amendment.save
      flash[:success] = t('amendments.update.success')
      
      respond_to do |format|
        format.html { redirect_to assembly_proposal_amendment_url(@assembly,@proposal,@amendment) }
        format.json { render :text => @amendment.to_json }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render :text => @amendment.to_json }
      end
    end
  end

  def destroy
    @amendment = Amendment.find(params[:id])
    authenticate_ownership(@amendment) and return
    if @amendment.destroy
      flash[:notice] = t('amendments.destroy.success')
      
      respond_to do |format|
        format.html { redirect_to assembly_proposals_path(@assembly) }
        format.json { render :text => @amendment.to_json }
      end
    else
      flash[:error] = t('amendments.destroy.error')
      respond_to do |format|
        format.html { redirect_to assembly_proposal_path(@assembly,@propsal,@amendment) }
        format.json { render :text => @amendment.to_json }
      end
    end
  end

end
