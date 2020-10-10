ActiveAdmin.register StayHome do 
   menu label: "Stays"

 permit_params :stay_name,:status,:stay_title,:stay_price,:address,:description,:cancellation_policy, :stay_rule, :other, :merchant_id,:stay_id,stay_images_attributes: [:stay_image,:_destroy, :id
],facility_ids:[]

  config.clear_action_items!

  action_item :only => :index do
      link_to "New Stay" , "/admin/stay_homes/new" 
  end 
  controller do
      def update
          update! do |format|
            UserMailer.merchant_stay_status(@stay_home).deliver_now
            format.html { redirect_to '/admin/merchants' }
          end
      end
  end

  index do 
    selectable_column
    id_column
    # column :upload_image
      column :stay_name
      column :stay_title
      column :address
      column :stay_price
      column :stay_id do |stay|
        Stay.all.find(stay.stay_id).name unless stay.stay_id.nil?
      end
      # byebug
       column "Status" do |s|
          StayHome::STATUS[s.status]
       end
      # img.upload_image 
    actions 
  end

  show do
    attributes_table do
      row :stay_name
      row :stay_title
      row :stay_price
      row :stay_id do |stay|
        Stay.all.find(stay.stay_id).name unless stay.stay_id.nil?
      end
      row :address
      row :description
      row :cancellation_policy
      row :stay_rule
        row "Status" do |s|
          StayHome::STATUS[s.status]
       end
    end

     panel "Stay Images", only: :show do
      attributes_table_for stay_home.stay_images do
        row "Stay Images" do |img|
      image_tag (img.stay_image.url),width: 70 , height: 70
    end
      end
    end
  end

  form html: { multipart: true } do |f|
    f.semantic_errors *f.object.errors.keys
        
      f.inputs "Stay" do
        f.input :stay_name ,required: true
        f.input :stay_title,required: true
        f.input :stay_price, required: true
        f.input :address,required: true
        f.input :stay_id, :label => 'Stay Categories', :as => :select, :collection => Stay.all.map{|u| ["#{u.name}", u.id]},required: true
        f.input :merchant_id, :label => 'Mearchant Name', :as => :select, :collection => Merchant.all.map{|u| ["#{u.name}", u.id]}
        f.input :description,as: :ckeditor
        f.input :stay_rule, required: true, as: :ckeditor
        f.input :cancellation_policy, required: true, as: :ckeditor
    end
    
    f.inputs do
      f.has_many :stay_images, heading: 'Stay Images',
                              allow_destroy: true,
                              new_record: true do |a|
          # a.input :stay_image,as: :file,required: true
          if a.object.new_record?
            a.input :stay_image,as: :file ,input_html: { required: true }
          else
            a.input :stay_image, as: :file, hint: a.template.image_tag(a.object.stay_image.url,width: 70 , height: 70)
          end
      end
      f.input :status, :label => 'STATUS', as: :select,collection: StayHome::STATUS.map{|w| w.reverse}
     # f.input :status, as: :select :design, :collection => options_for_select(['a','b','c']) 
    end

    f.inputs "Stay Facilities" do
      f.input :other, :label => 'Other Facilities'
          # a.input :stay_image,as: :file,required: true
      f.input :facility_ids,as: :tags, collection: Facility.all
      #f.input :status, as: :select, :collection => StayHome::STATUS.map { |st| [st, st , st] } 
    end

    actions do
      f.action :submit, label: "Create Stay"
    end
  end

  controller do
    before_action { @page_title = "Stay" }
  end
end
