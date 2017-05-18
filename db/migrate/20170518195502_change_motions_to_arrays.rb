class ChangeMotionsToArrays < ActiveRecord::Migration[5.0]
  def change
	 change_column :ibeacons, :x_motion, :string
	 change_column :ibeacons, :y_motion, :string
	 change_column :ibeacons, :z_motion, :string
  end
end
