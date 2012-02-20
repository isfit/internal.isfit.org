InternalIsfitOrg::Application.routes.draw do

  get 'organization_chart', controller: "organization_chart", action: "index"
  get "organization_chart/:year", controller: "organization_chart", action: "index"

  get 'oauth/start'
  get 'oauth/callback'
  
  resources :isfit_pages

  resources :presentations

  post "kvitters/create" => "kvitters#create"
  get "kvitters/last(:.format)" => "kvitters#last"
  resources :contact_logs


  resources :rooms 
  get "room_bookings/:week/:year" => "room_bookings#show", as: "new_room_booking"
  resources :room_bookings


  resources :spp_articles do
    collection do
      post 'photo'
    end
    member do
      get 'movedown'
      get 'moveup'
    end
  end
  
  resources :frontend_articles do
    collection do
      post 'photo'
    end
    member do
      get 'moveup'
      get 'movedown'
      get 'new_pic'
      post 'crop_main'
      post 'crop_create'
    end
  end
  
  resources :gallery_albums do
    collection do
      post 'add_photo'
      get 'destroy_photo'
      get 'update_photo'
    end
    resources :gallery_photos
  end

  resources :accounts do
    collection do
      get 'travel'
      get 'voucher'
      get 'festihvalen'
      post 'print_travel'
      post 'print_voucher'
      post 'print_festihvalen'
    end
  end

  # pads
  get "pads" => "pads#index"
  post "pads/create", :as => :create_pad
  get "pads/:hexid" => "pads#show", :as => "pad"
  get "pads/:hexid/delete" => "pads#delete", :as => "delete_pad"

  resources :applicants do
    collection do 
      get 'statistics'
      get 'interviews'
    end
  end

  resources :photos do
    member do
      get :crop
      post :crop_create
    end
  end
  resources :internal_tabs do 
    collection do
      post 'get_actions'
    end
  end
  resources :static_pages
  resources :articles
  resources :applicants
  match 'user/edit' => 'users#edit', :as => :edit_current_user
  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login
  resources :sessions
  resources :users do 
    collection do
      get 'username/:username', action: :username
      get 'change_password', action: :change_password
      post 'update_password', action: :update_password
    end
  end
  root :to => "articles#index"
end
