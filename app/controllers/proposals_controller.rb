class ProposalsController < ApplicationController
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
    @proposal = Proposal.create!(params)
  rescue ActiveRecord::RecordInvalid
    render :action => :new
  end

  def edit
    @proposal = Proposal.find(params[:id])
  end

  def update
    @proposal = Proposal.find(params[:id])
    @proposal.body = params[:body]
    @proposal.save
  end

  def destroy
    @proposal = Proposal.find(params[:id])
    @proposal.destroy
  end
end
