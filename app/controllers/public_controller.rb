class PublicController < ApplicationController
  skip_before_filter :init_parents
  skip_before_filter :authenticate_user!
  skip_before_filter :authorize_participation

  layout :public

  def index
  end

  def show
    @assembly = Assembly.find(params[:id])
  end

end
