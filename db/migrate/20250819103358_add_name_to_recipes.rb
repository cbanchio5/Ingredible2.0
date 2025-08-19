class AddNameToRecipes < ActiveRecord::Migration[8.0]
  def change
    add_column :recipes, :name, :string
  end
end
