class ProposalsController < ApplicationController
  def index
    @popular = Proposal.most_popular(10)
    @recent = Propsal.limit(10)
  end
end
