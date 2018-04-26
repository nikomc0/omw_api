class CreateReservations < ActiveRecord::Migration[5.1]
  def change
  	create_table :reservations do |t|
  		t.string :name
  		t.string :phone_number
  		t.references :restaurant, index: true, foreign_key: true
  	end
  end
end
