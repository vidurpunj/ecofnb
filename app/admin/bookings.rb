ActiveAdmin.register Booking do
 permit_params :user_id, :stay_home_id, :start_date, :last_date, :num_of_user, :room_id

 actions :index, :show
 
	index do 
    id_column
      column :user_id do |m|
        stay = User.find(m.user_id).name
      end
      column "Stays" do |m|
        stay = StayHome.find(m.stay_home_id).stay_name
      end
      column :start_date
      column :last_date
      column :num_of_user
      column "room" do |m|
        stay = Room.find(m.stay_home_id).name
      end
    actions
  end
end
