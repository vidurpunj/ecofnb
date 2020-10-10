ActiveAdmin.register Stay do
   menu label: "Stay Categories"
  permit_params :name

  config.clear_action_items!

  action_item :only => :index do
      link_to "New Stay Category" , "/admin/stays/new" 
  end 

  index do 
    id_column
      column :name
      
    actions
  end


  show do
    attributes_table do 
      row :name
    end
    
  end  

form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs  do
      input :name
    end
    actions do
      f.action :submit, label: "Create Stay Category"
    end 
  end

  controller do
    before_action { @page_title = "Stay Category" }
  end
end
