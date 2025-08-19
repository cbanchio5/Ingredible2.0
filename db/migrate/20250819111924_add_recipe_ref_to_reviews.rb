class AddRecipeRefToReviews < ActiveRecord::Migration[8.0]
  def change
    add_reference :reviews, :recipe, null: false, foreign_key: true
  end
end
