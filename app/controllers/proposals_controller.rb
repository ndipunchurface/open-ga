class ProposalsController < ApplicationController

  respond_to :html, :json

  def index
    @popular = Proposal.most_popular(10)
    @recent = Proposal.limit(10)

    respond_to do |format|
      format.html
      format.json { render :text => {:popular => @popular, :recent => @recent}.to_json }
    end
  end

  def show
    @proposal = @assembly.proposals.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :text => @proposal.to_json }
    end
  end

  def new
    @proposal = @assembly.proposals.build

    respond_to do |format|
      format.html
      format.json { render :text => @proposal.to_json }
    end
  end

  def create
    @proposal = @assembly.proposals.build(params[:proposal])

    if @proposal.save
      flash[:success] = t('proposals.create.success')
      
      respond_to do |format|
        format.html { redirect_to assembly_proposal_url(@assembly,@proposal) }
        format.json { render :text => @proposal.to_json }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render :text => @proposal.to_json }
      end
    end
  end

  def edit
    @proposal = @assembly.proposals.find(params[:id])
    authenticate_ownership(@proposal) and return

    respond_to do |format|
      format.html
      format.json { render :text => @proposal.to_json }
    end
  end

  def update
    @proposal = @assembly.proposals.find(params[:id])
    authenticate_ownership(@proposal)
    @proposal.title = params[:proposal][:title]
    @proposal.body = params[:proposal][:body]

    if @proposal.save!
      flash[:success] = t('proposals.update.success')
      
      respond_to do |format|
        format.html { redirect_to assembly_proposal_url(@assembly,@proposal) }
        format.json { render :text => @proposal.to_json }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render :text => @proposal.to_json }
      end
    end
  end

  def destroy
    @proposal = @assembly.proposals.find(params[:id])
    authenticate_ownership(@proposal)
    
    if @proposal.destroy
      respond_to do |format|
        format.html { redirect_to assembly_proposals_url(@assembly) }
        format.json { render :text => @proposal.to_json }
      end
    else
      flash[:error] = t('proposals.destroy.error')
      respond_to do |format|
        format.html { redirect_to assembly_proposal_url(@assembly,@proposal) }
        format.json { render :text => @proposal.to_json }
      end
    end
  end

end
