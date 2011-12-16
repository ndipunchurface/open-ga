class CategoriesController < ApplicationController
  skip_before_filter :init_parents
  skip_before_filter :authenticate_user!
  skip_before_filter :authorize_participation

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @assemblies = @category.assemblies
  end
end
