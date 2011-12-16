class RegistrationNumbersController < ApplicationController
  def index
    if current_user.is_admin?
      @registration_numbers = @assembly.registration_numbers.not_burned
    else
      flash[:error] = t('global.authorization_error')
      redirect_to assembly_path(@assembly)
    end
  end

  def new
    if current_user.is_admin?
      @registration_number = RegistrationNumber.new #really not doing anything, just for Form Helpers
    else
      flash[:error] = t('global.authorization_error')
      redirect_to assembly_path(@assembly)
    end
  end

  def create
    if current_user.is_admin?
      params[:num_to_gen].to_i.times do
        @assembly.registration_numbers.create
      end
    else
      flash[:error] = t('global.authorization_error')
      redirect_to assembly_path(@assembly)
    end
  end
end
