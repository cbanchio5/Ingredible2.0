class AddDetailsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :fullname, :string unless column_exists?(:users, :fullname)
    add_column :users, :admin, :boolean, default: false unless column_exists?(:users, :admin)
    add_column :users, :provider, :string, limit: 50, default: "" unless column_exists?(:users, :provider)
    add_column :users, :uid, :string, limit: 500, default: "" unless column_exists?(:users, :uid)
  end
end
