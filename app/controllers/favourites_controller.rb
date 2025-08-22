class FavouritesController < ApplicationController
   before_action :set_recipe, only: [:create]
   before_action :set_favourite, only: [:destroy]

def index

  @favourites = policy_scope(Favourite).where(user_id: current_user).includes(:recipe)
  @recipes = policy_scope(Recipe).sample(6)
  # if @favourites.user_id == current_user.id
  #   @favourites = policy_scope(Favourite)
  # end
end

def show
  @favourite = Favourite.find(params[:id])
  authorize @favourite
end

def new
  @favourite =  Favourite.new
  authorize @favourite
  @recipe = Recipe.find(params[:recipe_id])
  authorize @recipe
end

 def create
  @recipe = Recipe.find(params[:recipe_id])
  @favourite = Favourite.new(user: current_user, recipe: @recipe)
  authorize @favourite

  if @favourite.save
    respond_to do |format|
      format.html { redirect_back(fallback_location: recipe_path(@recipe), notice: "Added to favourites!") }
      if request.referer&.include?("recipes/#{@recipe.id}")
        format.turbo_stream { render :create_show }
      else
        format.turbo_stream
      end
    end
  else
    redirect_back(fallback_location: recipe_path(@recipe), alert: "Could not add to favourites.")
  end
end

def destroy
  @favourite = Favourite.find(params[:id])
  authorize @favourite
  @recipe = @favourite.recipe
  @favourite.destroy

  respond_to do |format|
    format.html do
      if request.referer&.include?("recipes/#{@recipe.id}")
        redirect_to recipe_path(@recipe)
      elsif request.referer&.include?("recipes")
        redirect_to recipes_path
      else
        redirect_to user_favourites_path(current_user)
      end
    end
    if request.referer&.include?("recipes/#{@recipe.id}")
      format.turbo_stream { render :destroy_show }
    else
      format.turbo_stream
    end
  end
end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def set_favourite
    @favourite = Favourite.find(params[:id])
  end


end
