json.extract! booking, :id, :user_id, :stay_home_id, :room_category_id, :start_date, :last_date, :num_of_user, :created_at, :updated_at
json.url booking_url(booking, format: :json)
