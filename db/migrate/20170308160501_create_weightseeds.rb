class CreateWeightseeds < ActiveRecord::Migration[5.0]
# seed data, will remember which ibeacons have which weights. 
  def change
    create_table :weightseeds do |t|
      t.integer :ibeacon_id
      t.integer :weight
      t.timestamps
    end
  end
end
