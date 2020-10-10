ActiveAdmin.register Merchant do
	permit_params :name,:email, :address, :mobile, :password,:password_confirmation,:status
	controller do
	    def update
      		update! do |format|
      			UserMailer.merchant_account_approve_notification(@merchant).deliver_now
        		format.html { redirect_to '/admin/merchants' }
      		end
  		end
	end

	index do
	  id_column
	  column :name
	  column :email
	  column :address
	  column :password
	  column :password_confirmation
	  column :mobile
	  column :status do |merchant|
	       Merchant::STATUS_REVERSE[merchant.status]
	   end
	  actions
	end

	form do |form|
	  form.inputs do
	   	if form.object.nil?
		   form.input :name, :label => 'Name'
		   form.input :email, :label => 'Email'
		   form.input :address, :label => 'Address'
		   form.input :password, :label => 'Password'
		   form.input :password_confirmation, :label => 'password_confirmation'
	       form.input :mobile, :label => 'Mobile'
	   else
		   	form.input :name, :label => 'Name'
			form.input :email, :label => 'Email'
			form.input :address, :label => 'Address'
		   	form.input :status, :label => 'STATUS', as: :select,collection: Merchant::STATUS
		end
	  end
	   form.actions
	end
end
