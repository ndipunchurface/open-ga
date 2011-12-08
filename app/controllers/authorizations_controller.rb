class AuthorizationsController < ApplicationController
  skip_before_filter :authorize_participation

  def new
    @authorization = Authorization.new
  end

  def create
    if authentic_registration_number?(params[:registration_number].downcase)
      current_user.authorize(@assembly)
      flash[:success] = "You've successfully registered for this Assembly."
      redirect_to assembly_path(@assembly)
    else
      flash[:error] = "The registration number you've entered is invalid"
      render :new
    end
  end

  private

  def authentic_registration_number?(number)
    @assembly.registration_numbers.find(:all, :conditions => ["uuid = ?", number.to_s]).length > 0
  end
end
