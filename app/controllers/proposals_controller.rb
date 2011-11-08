class ProposalsController < ApplicationController
  def index
    @popular = Proposals.most_popular(10)
    @recent = Propsals.limit(10)
  end
end
