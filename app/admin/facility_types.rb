ActiveAdmin.register FacilityType do
 permit_params :name
 index do 
    id_column
      column :name
      column :created_at
      column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      input :name 
    end
    actions
  end

  show do
    attributes_table do 
      row :name
      row :created_at
      row :updated_at
    end
  end 

end
