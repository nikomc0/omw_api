class Create_Restaurants < ActiveRecord::Migration[5.1]
  def change
  	create_table :restaurants do |t|
  		t.string :location
  		t.string :name
  	end
  end

  def down
  	drop_table :restaurants
  end
end