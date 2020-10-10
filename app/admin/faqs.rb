ActiveAdmin.register Faq do
 permit_params :question, :description, :faq_type_id
	
 index do 
    id_column
      column :question
      column :faq_type
      column :created_at
      column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      input :faq_type_id, as: :select, :collection => FaqType.all.map{|c| ["#{c.name}", c.id]}
      input :question 
      input :description, as: :ckeditor
    end
    actions
  end

  show do
    attributes_table do 
      row :question
      row :faq_type
      row :description 
      row :created_at
      row :updated_at
    end
  end 

end
