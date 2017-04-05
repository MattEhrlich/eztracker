class AddIndexToUserOnUserprofile < ActiveRecord::Migration[5.0]
  def change
	  add_column :userprofiles, :user_id, :integer 
	  add_index :userprofiles, :user_id
  end
end
