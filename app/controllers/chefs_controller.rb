class ChefsController < ApplicationController
  before_action :set_chef, only: [:show]

  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 5)
  end

  def show
    @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 5)
  end

  private

  def set_chef
    @chef = Chef.find(params[:id])
  end
end
