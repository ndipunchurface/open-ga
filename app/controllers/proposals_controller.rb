class ProposalsController < ApplicationController

  def index
    @popular = Proposal.most_popular(10)
    @recent = Proposal.limit(10)
  end

  def show
    @proposal = @assembly.proposals.find(params[:id])
  end

  def new
    @proposal = @assembly.proposals.build
  end

  def create
    @proposal = @assembly.proposals.build(params[:proposal])

    if @proposal.save
      flash[:success] = t('proposals.create.success')
      redirect_to assembly_proposal_url(@assembly,@proposal)
    else
      render :new
    end
  end

  def edit
    @proposal = @assembly.proposals.find(params[:id])
   
    authenticate_ownership(@proposal)
  end

  def update
    @proposal = @assembly.proposals.find(params[:id])
    authenticate_ownership(@proposal)
    @proposal.title = params[:proposal][:title]
    @proposal.body = params[:proposal][:body]

    if @proposal.save!
      flash[:success] = t('proposals.update.success')
      redirect_to assembly_proposal_url(@assembly,@proposal)
    else
      render :edit
    end
  end

  def destroy
    @proposal = @assembly.proposals.find(params[:id])
    authenticate_ownership(@proposal)
    @proposal.destroy

    render :index
  end

  def flag
    @proposal = @assembly.proposals.find(params[:id])
    @proposal.flag
  end

end
