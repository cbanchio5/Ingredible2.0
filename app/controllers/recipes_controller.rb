class RecipesController < ApplicationController
  # the page will be seen by every user
  skip_before_action :authenticate_user!, only: :index

  def index
    @recipes = policy_scope(Recipe).order(created_at: :desc).includes(:reviews)
    @recipes = Recipe.search_by_name_and_ingredients(params[:query]) if params[:query].present?
    @reviews = policy_scope(Review)
    @favourites = policy_scope(Favourite)
    @communities = policy_scope(Community)
    @recipes2 = policy_scope(Recipe)
    @search = params[:query] || params[:difficulty]
    @recipes = @recipes.select { |recipe| recipe.difficulty == params[:difficulty] } if params[:difficulty]
  end

  # if params[:query].present?
    # @recipes = policy_scope(Recipe).order(created_at: :desc)
    # @recipes = Recipe.search_by_address_and_description(params[:query]) #go to movie.rb file to understand reference

  # else
    # @recipes = policy_scope(Recipe).order(created_at: :desc)
  # end

  def show
    @recipe = Recipe.find(params[:id])
    # @booking = Booking.new

    authorize @recipe
    @review = Review.new
    authorize @review
    @favourites = policy_scope(Favourite)
    # authorize @booking
  end

  def myrecipes
    @recipes = Recipe.where(user: current_user).includes(:favourites)
    authorize @recipes
  end

  def new
    @recipe = Recipe.new
    authorize @recipe
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    authorize @recipe
    if @recipe.save
      redirect_to @recipe, notice: 'You have created a new recipe'
    else
      render :new
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.user = current_user
    authorize @recipe
    @recipe.update(recipe_params)
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: 'You have updated a recipe'
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    authorize @recipe
    @recipe.destroy
    redirect_to recipes_path, notice: 'Recipe was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
      authorize @recipe
    end

      # Only allow a list of trusted parameters through.
       def recipe_params
         params.require(:recipe).permit(:name, :ingredients, :difficulty, :time, :steps, :serves, :category, :photo)
       end
end
