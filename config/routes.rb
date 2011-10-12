InternalIsfitOrg::Application.routes.draw do
  resources :contact_logs

  resources :kvitters

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

  resources :accounts do
    collection do
      get 'travel'
      get 'voucher'
      post 'print_travel'
      post 'print_voucher'
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
  resources :users
  root :to => "articles#index"
end
