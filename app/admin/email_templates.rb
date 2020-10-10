ActiveAdmin.register EmailTemplate do

permit_params :user_admincheckout_email

index do
    id_column
    column :user_admincheckout_email
    actions
  end
end
