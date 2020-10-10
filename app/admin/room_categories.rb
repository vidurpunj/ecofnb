ActiveAdmin.register RoomCategory do
  permit_params :category_name, :category_price, :stay_home_id

  index do 
    id_column
      column :category_name
      column :category_price
      column "Home Stay" do |m|
        stay = StayHome.find(m.stay_home_id).stay_name rescue nil
      end
    actions
  end

  form do |f|
    f.inputs do
      input :category_name ,required: true
      input :category_price, required: true
      input :stay_home_id, :label => 'Stays', :as => :select, :collection => StayHome.all.map{|u| ["#{u.stay_name}", u.id]}, required: true
    end
    actions
  end

  show do
    attributes_table do 
      row :category_name
      row :category_price
        row "Stays" do |m|
          stay = StayHome.find(m.stay_home_id).stay_name
        end 
    end
  end
end
