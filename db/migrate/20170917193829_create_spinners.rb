class CreateSpinners < ActiveRecord::Migration[5.0]
  def change
    create_table :spinners do |t|
      t.integer :is_moving
      t.timestamps
    end
  end
end
