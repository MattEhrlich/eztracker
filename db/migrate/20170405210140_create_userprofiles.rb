class CreateUserprofiles < ActiveRecord::Migration[5.0]
  def change
    create_table :userprofiles do |t|
	   t.string :full_name
	   t.string :profile_image
	   t.integer :weight
	   t.string :fitness_goal

      t.timestamps
    end
  end
end
