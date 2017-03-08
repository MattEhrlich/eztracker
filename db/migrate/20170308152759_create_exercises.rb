class CreateExercises < ActiveRecord::Migration[5.0]
    # This should be "seed data." We need to record Matt to preform each excersie very well in order for our program to know the difference between each exercise by the info the accelometer gives us.
  def change
    create_table :exercises do |t|
      t.string :name
      t.float :x_accel
      t.float :y_accel
      t.float :z_accel
      
      t.timestamps
    end
  end
end
