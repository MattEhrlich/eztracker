class CreateIbeacons < ActiveRecord::Migration[5.0]
 # since ibeacon data will constantly come in, this data should be deleted if ibeacon is not in motion and if the workout is over
  def change
    create_table :ibeacons do |t|
      t.string :x_motion
      t.string :y_motion
      t.string :z_motion
      t.string :exercise_name
      t.integer :reps_counted
      t.timestamps
    end
  end
end
