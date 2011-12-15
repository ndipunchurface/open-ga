class AuthorizationsController < ApplicationController
  skip_before_filter :authorize_participation

  def new
    @authorization = Authorization.new
  end

  def create
    if authentic_registration_number?(params[:registration_number].downcase)
      current_user.authorize(@assembly)
      flash[:success] = t('authorizations.create.success')
      redirect_to assembly_path(@assembly)
    else
      flash[:error] = t('authorizations.create.error')
      render :new
    end
  end

  def update
    authorize_ownership(@assembly)
    @authorization = Authorization.find(params[:id])
    @authorization.role = 1 #bump to facilitator
    redirect_to user_path(current_user)
  end

  private

  def authentic_registration_number?(number)
    @assembly.registration_numbers.find(:all, :conditions => ["uuid = ?", number.to_s]).length > 0
  end
end
