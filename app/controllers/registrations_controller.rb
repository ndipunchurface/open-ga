class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :check_logged_in
  skip_before_filter :init_parents

  def new
    super
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
