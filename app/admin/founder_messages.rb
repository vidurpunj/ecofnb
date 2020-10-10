ActiveAdmin.register FounderMessage do

 permit_params :image,:title,:description 

	index do 
    id_column
   		column "FounderMessage Image" do |img|
	 	  image_tag (img.image.url) ,width: 60
	 	  # img.upload_image 
	    end
      column :title
      
    actions
  end


  show do
    attributes_table do 
      
      row :image do |img|
        image_tag (img.image.url), width: 80  
      end
      row :title
      row :description
    end
    
  end  

form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      input :image ,required: true, as: :file ,:hint => f.object.image.present? \
					    ? image_tag(f.object.image.url ,width: 70 , height: 70)
					    : content_tag(:span, "")
      input :title
      input :description, as: :ckeditor
    end
    actions
  end
end
