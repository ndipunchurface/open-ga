class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale, :unless => :devise_controller?
  before_filter :init_parents, :unless => :devise_controller?
  before_filter :authenticate_user!, :unless => :devise_controller?
  before_filter :authorize_participation, :unless => :devise_controller?
  
  private

  def is_admin?
    assembly = @assembly.nil? ? Assembly.find_by_uuid_or_alias(params[:id]) : @assembly
    current_user.is_admin?(assembly)
  end

  def set_locale
      I18n.locale = user_signed_in? ? current_user.locale : I18n.default_locale
  end

  def authorize_participation
    assembly = params[:assembly_id].nil? ? Assembly.find_by_uuid_or_alias(params[:id]) : @assembly
    unless current_user.authorized?(assembly.uuid)
      flash[:error] = t('assemblies.registration_error')
      redirect_to new_assembly_authorization_path(assembly) 
    end
  end

  def authenticate_ownership(instance)
    unless instance.user_id == current_user.id
      flash[:error] = t('global.authorization_error')
      redirect_to :action => 'index' 
    end
  end

  def check_admin
    if !is_admin?
      flash[:error] = t('global.authorization_error')
      redirect_to assembly_url(params[:assembly_id] || params[:id]) 
    end
  end

  def init_parents
    @assembly = Assembly.find_by_uuid_or_alias(params[:assembly_id]) unless params[:assembly_id].nil?
    @proposal = Proposal.find(params[:proposal_id]) unless params[:proposal_id].nil?
    @amendment = Amendment.find(params[:amendment_id]) unless params[:amendment_id].nil?
  end

  def model
    self.class.to_s.gsub(/([a-zA-Z]+)Controller/,'\1').singularize.constantize
  end

end
