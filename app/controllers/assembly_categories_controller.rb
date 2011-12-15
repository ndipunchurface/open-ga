class AssemblyCategoriesController < ApplicationController
  def index
    @categories = AssemblyCategory.all
  end

  def show
    @category = AssemblCategory.find(params[:id])
    @assemblies = @category.assemblies
  end
end
