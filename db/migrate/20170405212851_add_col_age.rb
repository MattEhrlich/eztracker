class AddColAge < ActiveRecord::Migration[5.0]
  def change
	  add_column :userprofiles, :age, :date
  end

end
