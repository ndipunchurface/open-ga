class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :init_parents
  
  private

  def is_admin?
    current_user.is_admin?
  end

  def init_parents
    @assembly = Assembly.find(params[:assembly_id])
    @proposal = Proposal.find(params[:proposal_id]) unless params[:proposal_id].nil?
    @amendment = Amendment.find(params[:amendment_id]) unless params[:amendment_id].nil?
  end
end
