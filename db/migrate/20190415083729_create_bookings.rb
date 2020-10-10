class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.integer :stay_home_id
      t.date :start_date
      t.date :last_date
      t.integer :num_of_user
      t.integer :room_id

      t.timestamps
    end
  end
end
