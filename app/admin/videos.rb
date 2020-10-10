ActiveAdmin.register Video do
 permit_params :video_link,:content,:active

index do 
    id_column
      column :video_link
      column :content
      toggle_bool_column 'Active', :active
    actions
  end

end
