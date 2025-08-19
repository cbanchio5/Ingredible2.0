class AddCommunityIdToMemberships < ActiveRecord::Migration[8.0]
  def change
    add_reference :memberships, :community, null: false, foreign_key: true
  end
end
