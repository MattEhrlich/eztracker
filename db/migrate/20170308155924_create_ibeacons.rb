class CreateIbeacons < ActiveRecord::Migration[5.0]
 # since ibeacon data will constantly come in, this data should be deleted if ibeacon is not in motion and if the workout is over
  def change
    create_table :ibeacons do |t|
      t.float :x_motion
      t.float :y_motion
      t.float :z_motion
      t.integer :ibeacon_id
      t.timestamps
    end
  end
end
