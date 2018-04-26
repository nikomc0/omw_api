class AddPhoneNumberToReservations < ActiveRecord::Migration[5.1]
  def change
  	add_column :reservations, :phone_number, :string
  end
end
