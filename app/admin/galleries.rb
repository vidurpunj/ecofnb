ActiveAdmin.register Gallery do

 permit_params :image, :of, :attributes, :on, :model

	index do
		id_column
		# column :upload_image
		column :pg_type , :label=>"Photo Gallery Type"
		column "Gallery" do |img|
	 	  image_tag (img.image.url) ,width: 50
	 	  # img.upload_image 
	    end
	  actions

	end

	show do
		attributes_table do 
			row :pg_type , :label=>"Photo Gallery Type"
			row :image do |img|
				image_tag (img.image.url), width: 50  
			end
		end
		
	end

	form(:html => { :multipart => true }) do |f|
		
	    f.inputs "Gallery" do
	    	f.input :pg_type, :label => 'Photo Gallery Type', as: :select,collection: PhotogalleryType.all.collect{ |u| [u.title, u.title] }
	      f.input :image,required: true, as: :file, input_html: { multiple: true }
		  end
	    f.actions
	end

	controller do
	  def create
	  	if params[:gallery][:image].present?
		  	params[:gallery][:image].each do |image1|
			    @image = Gallery.new(image: image1,pg_type: params[:gallery][:pg_type])
			    @image.save
			  end
			  flash[:notice] = "Gallery Uploaded"
			  redirect_to "/admin/galleries"
		else
			flash[:error] = "Please select images"
			redirect_to "/admin/galleries/new"
		end		  
	  end 

	  def update
	  	@pre_image = Gallery.find(params[:id])
	  	@image = @pre_image.update(image: params[:gallery][:image].first, pg_type: params[:gallery][:pg_type])
	  	flash[:notice] = "Gallery Uploaded"
	  	redirect_to "/admin/galleries"
	  end
	end
end
