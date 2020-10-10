ActiveAdmin.register Facility do
 permit_params :name, :facility_type_id,:facility_icon_id
 index do 
    id_column
      column :name
      column :facility_type
      column :created_at
      column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      input :name 
      input :facility_type_id, as: :select, :collection => FacilityType.all.map{|c| ["#{c.name}", c.id]}
      input :facility_icon_id, as: :select, :collection => FacilityIcon.all.map{|c| ["#{c.icon}", c.id]}  
    end
    actions
  end

  show do
    attributes_table do 
      row :name
      row :facility_type 
      row :created_at
      row :updated_at
    end
  end 

end
