class AddDetailsToRecipes < ActiveRecord::Migration[8.0]
  def change
    add_reference :recipes, :user, null: false, foreign_key: true
    add_column :recipes, :ingredients, :text
    add_column :recipes, :difficulty, :string
    add_column :recipes, :time, :string
    add_column :recipes, :steps, :text
    add_column :recipes, :serves, :integer
    add_column :recipes, :category, :string
  end
end
