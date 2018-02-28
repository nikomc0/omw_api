class Create_Restaurants < ActiveRecord::Migration[5.1]
  def change
  	drop_table :restaurants 
  	create_table :restaurants do |t|
  		t.string :location
  		t.string :name
  	end
  end

  def down
  	drop_table :restaurants
  end
end
