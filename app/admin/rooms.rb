ActiveAdmin.register Room do

 permit_params :name, :room_category_id, :stay_home_id

	index do 
    id_column
      column :name
      column "Stays" do |r|
        stay = RoomCategory.find(r.room_category_id).category_name rescue nil
      end
      column "Stays" do |m|
        stay = StayHome.find(m.stay_home_id).stay_name rescue nil
      end
    actions
  end

  form do |f|
    f.inputs do
      input :name ,required: true
      input :room_category_id, :label => 'Room Category', :as => :select, :collection => RoomCategory.all.map{|rc| ["#{rc.category_name}", rc.id]},required: true
      input :stay_home_id, :label => 'Stays', :as => :select, :collection => StayHome.all.map{|u| ["#{u.stay_name}", u.id]},required: true
    end
    actions
  end

  show do
    attributes_table do 
      row :name
      row "Room Category" do |r|
      stay = RoomCategory.find(r.room_category_id).category_name
      end 
      row "Stays" do |m|
      stay = StayHome.find(m.stay_home_id).stay_name
      end 
    end   
  end 
end
