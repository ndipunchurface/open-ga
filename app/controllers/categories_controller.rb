class CategoriesController < ApplicationController
  skip_before_filter :init_parents
  skip_before_filter :authenticate_user!
  skip_before_filter :authorize_participation

  respond_to :html, :json

  def index
    @categories = Category.all

    respond_to do |format|
      format.html
      format.json { render :text => @categories.to_json }
    end
  end

  def show
    @category = Category.find(params[:id])
    @assemblies = @category.assemblies

    respond_to do |format|
      format.html
      format.json { render :text => @category.to_json }
    end
  end
end
