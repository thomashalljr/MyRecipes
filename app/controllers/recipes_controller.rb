class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy, :like]
  before_action :authenticate_chef!, except: [:index, :show]
  before_action :require_same_user_or_admin, only: [:edit, :update, :destroy]

  def index
    @recipes = Recipe.reorder("lower(name) asc").paginate(page: params[:page], per_page: 5)
  end

  def show
    @comment = Comment.new
    @comments = @recipe.comments.paginate(page: params[:page], per_page: 5)
  end

  def new
    @recipe = Recipe.new
  end

  def edit
  end

  def create
    @recipe = Recipe.new recipe_params
    @recipe.chef = current_chef

    add_cloudinary_image

    if @recipe.save
      flash[:success] = "Recipe was created successfully!"
      redirect_to recipe_path(@recipe)
    else
      render "new"
    end
  end

  def update
    add_cloudinary_image

    if @recipe.update recipe_params
      flash[:success] = "Recipe was updated successfully!"
      redirect_to recipe_path(@recipe)
    else
      render "edit"
    end
  end

  def destroy
    Recipe.find(params[:id]).destroy
    flash[:success] = "Recipe was deleted successfully"
    redirect_to recipes_path
  end

  def like
    like = Like.create(like: params[:like], chef: current_chef, recipe: @recipe)

    if like.valid?
      flash[:success] = "Your selection was successful"
    else
      flash[:danger] = "You can only like/dislike a recipe once"
    end
    redirect_back(fallback_location: recipe_path(@recipe))
  end

  private

  def set_recipe
    @recipe = Recipe.find params[:id]
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :image, :remove_image, {recipe_ingredients_attributes: [:id, :ingredient_id, :_destroy]})
  end

  def require_same_user_or_admin
    unless (current_chef == @recipe.chef) || current_chef.admin?
      flash[:danger] = "You can only edit or delete your own recipes"
      redirect_to recipes_path
    end
  end

  def add_cloudinary_image
    if params[:recipe][:image].present?
      preloaded = Cloudinary::PreloadedFile.new params[:recipe][:image]
      raise "Invalid image upload" if !preloaded.valid?
      @recipe.image = preloaded.identifier
    end
  end
end
