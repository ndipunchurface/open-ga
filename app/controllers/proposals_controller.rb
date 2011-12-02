class ProposalsController < ApplicationController
  #TODO apply authentication to edit/update/destroy
  def index
    @popular = Proposal.most_popular(10)
    @recent = Propsal.limit(10)
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  def new
    @proposal = Proposal.new
  end

  def create
    @proposal = @assembly.proposals.build(params[:proposal])

    if @proposal.save
      flash[:success] = "Proposal submitted successfully"
      redirect_to assembly_proposal_url(@assembly,@proposal)
    else
      render :new
    end
  end

  def edit
    @proposal = @assembly.proposals.find(params[:id])
  end

  def update
    @proposal = @assembly.proposals.find(params[:id])
    @proposal.title = params[:proposal][:title]
    @proposal.body = params[:proposal][:body]

    if @proposal.save
      flash[:success] = "Proposal updated successfully"
      redirect_to assembly_proposal_url(@assembly,@proposal)
    else
      render :edit
    end
  end

  def destroy
    @proposal = @assembly.proposals.find(params[:id])
    @proposal.destroy
  end

  private
end
