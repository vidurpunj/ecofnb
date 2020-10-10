json.extract! room, :id, :name, :stay_home_id, :room_category_id, :created_at, :updated_at
json.url room_url(room, format: :json)
