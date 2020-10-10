Rails.application.routes.draw do

  # devise_for :merchants
  get 'errors/not_found'
  get 'errors/internal_server_error'
  post 'uploader' => 'blogs#uploader'
  post '/ckeditor/pictures' , :to => 'blogs#ckeditor_picture',:defaults => { :format => 'json' }
  resources :booking_dates
  
  resources :bookings
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, path: 'users'
  
  devise_for :merchants, path: 'merchants', controllers: { sessions: "merchants/sessions", registrations: "merchants/registrations"}

  devise_scope :merchants do
    get '/merchants/sign_out' => 'devise/sessions#destroy'
  end
  devise_scope :merchant do
    get '/merchants/pertner_sign_up_with_email' ,:to => 'merchants/registrations#pertner_sign_up_with_email'
  end

  get 'merchants_status_approved' => 'application#merchants_status_approved'
  
  devise_scope :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  match '/auth/:provider/callback', :to => 'sessions#create', via: [:get, :post] 
  match '/auth/failure', :to => 'sessions#failure', via: [:get, :post] 



  match '/paytm_payment' => 'payment_systems#start_payment', via: [:post], :as => :paytm_payment
  match '/confirm_payment' => 'payment_systems#verify_payment', via: [:post]

  namespace :ecofnb do
    get 'index'
    get 'ecofriendly'
    get 'filter_search_stay'
    get 'about'
    get 'all_stay_homes'
    get 'founder_message' 
    get 'help'
    get 'support'
  end
  
  namespace :profile do
    get 'guest_profile'
  end

namespace :blogs do
    get 'short_blog'
  end

  root 'ecofnb#index'

  resources :contacts, only: [:new ,:create]
  resources :blogs, only: [:index,:show]

 resources :galleries ,only: [:index]
 namespace :galleries do
    get 'video'
    get 'merchant'
  end
  
 resources :stay ,only:[:show] do
  member do
    get 'bookings/new'
  end
 end


 resources :bookings, only: [:new, :create] do 
    collection do
      get :search_rooms
      # route for checkig available_rooms
      get :available_rooms
    end
  end

  resources :stay, only: [] do
    member do
      get 'bookings/new'
    end
    # Using booking resources
    resources :bookings, only: [:new, :create] do 
      collection do
        get :search_rooms
        # route for checkig available_rooms
        get :available_rooms
      end
    end
  end

 # resources :rating_reviews
 resources :faqs, only: [:index]
 resources :merchant

  get 'orders' => 'merchant#booking_order'
  get 'my_account' => 'merchant#profile'

 resources :stay_homes do
  member do
    resources :rating_reviews
    get :stay_status_approved
  end
 end

 scope :path => '/stay_homes/:stay_home_id' do
  resources :rooms, :controller => :rooms do
  end
end
# scope :path => '/stay_homes/:stay_home_id' do
  resources :room_categories #, :controller => :room_categories do
  # end
# end
 controller 'ecofnb' do
   # get 'beverage_locations/new' => 'beverage_locations#new'
   get '/Stay/:stay_id' => 'ecofnb#stay_category'
   get 'signup_with_email' =>'ecofnb#signup_with_email'
end

match "/404", :to => "errors#not_found", :via => :all
match "/500", :to => "errors#internal_server_error", :via => :all
match "/422", :to => "errors#unacceptable" , :via => :all
end

