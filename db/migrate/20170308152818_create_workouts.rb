class CreateWorkouts < ActiveRecord::Migration[5.0]
  def change
    create_table :workouts do |t|
      t.integer :exercise_id
      t.integer :user_id
      t.string :workout_id
      t.integer :weight
      t.boolean :good_performance?
      t.timestamps
    end
  end
end
