class AddBodyToReviews < ActiveRecord::Migration[8.0]
  def change
    add_column :reviews, :body, :text
  end
end
