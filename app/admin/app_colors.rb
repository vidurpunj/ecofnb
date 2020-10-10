ActiveAdmin.register AppColor do
permit_params :header_color, :header_hover


	form do |form|
		form.semantic_errors *form.object.errors.keys
		   form.inputs do
			   form.input :header_color,as: :color
			   form.input :header_hover, as: :color
			end
		form.actions
	end

end
