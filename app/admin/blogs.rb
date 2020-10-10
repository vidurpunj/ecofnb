ActiveAdmin.register Blog do

 permit_params :image,:title,:role,:upper_description,:lower_description, :attributes, :on, :model

index do 
    id_column
      column :title
      column :upper_description do |post|
        truncate(post.upper_description, omision: "...", length: 50)
      end
    actions
  end


  show do
    attributes_table do 
      
      row :image do |img|
        image_tag (img.image.url), width: 80  
      end
      row :title
      row :upper_description
      row :lower_description
      
    end
    
  end  

form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      input :image ,required: true, as: :file
      input :title ,required: true
      input :upper_description, as: :ckeditor
      input :lower_description, as: :ckeditor
    end
    actions
  end
end
