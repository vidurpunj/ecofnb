ActiveAdmin.register AboutU do

 permit_params :image,:title,:description 

	index do 
    id_column
      column :title
      
    actions
  end


  show do
    attributes_table do 
      row :title
      row :description
    end
    
  end  

form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      input :title
      input :description, as: :ckeditor
    end
    actions
  end
end
