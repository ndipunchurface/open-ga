class RegistrationNumbersController < ApplicationController
  def index
    registration_numbers = @assembly.registration_numbers.not_burned
  end

  def create
  end
end
