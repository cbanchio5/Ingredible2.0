class AddUserAndCommunityToMemberships < ActiveRecord::Migration[8.0]
  def change
    add_reference :memberships, :user, null: false, foreign_key: true
  end
end
