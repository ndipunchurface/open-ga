class RegistrationsController < ApplicationController
  skip_before_filter :authorize_participation

  def new
  end

  def create
    reg_num = RegistrationNumber.find_by_number(params[:registration_number])
    if !reg_num.nil? && reg_num.active
      reg_num.burn_number
      super
    else
      flash[:error] = "Invalid Registration Number."
      redirect_to :action => 'new'
    end
  end

  def update
    super
  end
end
