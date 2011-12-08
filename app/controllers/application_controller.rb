class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :init_parents
  before_filter :authenticate_user!, :unless => :devise_controller?
  before_filter :authorize_participation, :unless => :devise_controller?
  
  private

  def is_admin?
    current_user.is_admin?
  end

  def authorize_participation
    assembly = params[:assembly_id].nil? ? params[:id] : params[:assembly_id]
    unless current_user.authorized?(assembly.to_s)
      flash[:error] = "You must be registered for this Assembly before you can view it."
      redirect_to new_assembly_authorization_path(assembly) 
    end
  end

  def authenticate_ownership(instance)
    unless instance.user_id == current_user.id
      flash[:error] = "You are not authorized to perform this action"
      redirect_to :action => 'index' 
    end
  end

  def init_parents
    @assembly = Assembly.find(params[:assembly_id]) unless params[:assembly_id].nil?
    @proposal = Proposal.find(params[:proposal_id]) unless params[:proposal_id].nil?
    @amendment = Amendment.find(params[:amendment_id]) unless params[:amendment_id].nil?
  end

  def model
    self.class.to_s.gsub(/([a-zA-Z]+)Controller/,'\1').singularize.constantize
  end

end
