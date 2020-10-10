ActiveAdmin.register User do
  permit_params :name,:email, :password,:phone, :terms_of_service,:password_confirmation
  
  

  form do |f|
    f.inputs "User" do
      f.input :email
      f.input :name
      f.input :phone
      f.input :password
      f.input :terms_of_service
    end
    f.actions 
   
  end

end
