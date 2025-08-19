class FavouritesController < ApplicationController

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
      format.turbo_stream
    end
  else
    redirect_back(fallback_location: recipe_path(@recipe), alert: "Could not add to favourites.")
  end
end


def destroy
  puts "ESTE ES LA REQUEST #{request.headers["referer"]}"
  @favourite = Favourite.find(params[:id])
  authorize @favourite
  #raise
  @favourite.destroy
  if request.headers["referer"].include?("recipes/")
    redirect_to recipe_path(@favourite.recipe_id)
  elsif request.headers["referer"].include?("recipes")
    redirect_to recipes_path
  else
    redirect_to user_favourites_path(current_user)
  end
end

end
