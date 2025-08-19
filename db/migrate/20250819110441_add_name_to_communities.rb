class AddNameToCommunities < ActiveRecord::Migration[8.0]
  def change
    add_column :communities, :name, :string
  end
end
