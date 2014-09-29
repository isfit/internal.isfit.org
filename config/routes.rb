InternalIsfitOrg::Application.routes.draw do

  resources :motds


  resources :isfit_tabs do
    member do
      get 'moveup'
      get 'movedown'
      get 'moveup_page'
      get 'movedown_page'
      get 'set_weight_page'
    end
  end

  

  resources :hosts

  resources :events
  get "events/:id/attend" => "events#attend"
  get "events/:id/remove" => "events#remove"

#for å legge til ny subsciber
  post 'subscription/:subscription' => 'subscription#new_subscriber', as: 'subscription'
  post 'unsubscription/:unsubscription' => 'subscription#undo_subscriber', as: 'unsubscription' 

  resources :participant_quotes

  resources :layout_jobs do
    collection do
      post :receive_edit, action: :receive_edit, as: "receive_edit"
    end
  end

  resources :indaba_speakers

  get "who_am_i/index"
  get "who_am_i/game"
  get "who_am_i/highscore"
  post "who_am_i/game" => "who_am_i#game"

  get "what_am_i/game" => "what_am_i#game"
  post "what_am_i/game" => "what_am_i#game"
  get "what_am_i/highscore" => "what_am_i#highscore"

  get "users/status", controller: "card_checker", action: "status"
  get "users/status/init", controller: "card_checker", action: "init"
  post "users/status/update", controller: "card_checker", action: "update"

  namespace :transport do
    root :to => "drives#search", :via => [:post,:get], :as => "transport_root"
    get 'shifts/new' => "shifts#multiple_new"
    get 'shifts/' => "shifts#all"
    post 'shifts/create' => "shifts#multiple_create"
    resources :drivers do
      resources :shifts
      resources :drives
    end

    resources :cars
    resources :drives do
      collection do
        get 'search' => 'drives#search'
        get 'search/result' => 'drives#search_result'
        get "range_search", action: :range_search
      end
      member do
        put "toogle_completed", action: :toogle_completed
      end
    end
  end
  
  resources :spp_pages

  scope "/wiki" do
    get "", controller: "wiki_pages", action: "index"
    get "*category_slug/:page_slug", controller: "wiki_pages", action: "wiki_show"
  end


  resources :wiki_pages

  resources :wiki_categories

  get 'organization_chart(.:format)', controller: "organization_chart", action: "index", :as => "organization_chart"
  get "organization_chart/section/:id(.:format)", controller: "organization_chart", action: "section", :as => "organization_chart_section"
  get "organization_chart/group/:id(.:format)", controller: "organization_chart", action: "group", :as => "organization_chart_group"
  get "organization_chart/board/:id(.:format)", controller: "organization_chart", action: "board", :as => "organization_chart_board"

  resources :participants, :only => [:index] do
    collection do
      get "stats"
      get 'search' => 'participants#search', :via => [:get, :post], :as => :search
      # post "search", to: "participants#index"
      get "map_search"
    end
  end

  resources :dialogue_participants, :only => [:index, :show, :edit, :update]

  get 'oauth/start'
  get 'oauth/callback'
  
  resources :isfit_pages

  resources :presentations

  post "kvitters/create" => "kvitters#create"
  get "kvitters/last(:.format)" => "kvitters#last"
  get "kvitters/" => "kvitters#index", as: "kvitters"
  get "kvitters/:id/awesome" => "kvitters#awesome"

  get "hashtags/:hashtag" => "hashtags#show"
  
  get "contact_logs/new/:contact_log_unit_id" => "contact_logs#new", as: "new_contact_log_with_unit"
  resources :contact_logs, except: [:edit, :update, :create]
  resources :contact_log_units, except: [:edit, :update, :create]
  resources :contact_log_people, except: [:edit, :update, :create]
  resources :rooms 
  get "room_bookings/:week/:year" => "room_bookings#new", as: "new_room_booking"
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

  resources :campaign_stories do
    member do
      get 'validatestory'
      get 'delete'
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
      get 'invoice'
      get 'festihvalen'
      post 'print_travel'
      post 'print_voucher'
      post 'print_invoice'
      post 'print_festihvalen'
    end
  end

  # pads
  get "pads" => "pads#index"
  post "pads/create", :as => :create_pad
  get "pads/:hexid" => "pads#show", :as => "pad"
  get "pads/:hexid/delete" => "pads#delete", :as => "delete_pad"

  get "plingfest" => "applicants#notifier"
  get "last_applicant" => "applicants#last"

  resources :applicants do
    collection do 
      get 'statistics'
      get 'interviews'
    end
  end

  resources :workshops do
    resources :workshops_images
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
  post 'articles/attending/:article_id' => 'articles#attending', as: :attending_article
  post 'articles/notattending/:article_id' => 'articles#notattending', as: :not_attending_article

  resources :applicants
  get 'user/edit' => 'users#edit', :as => :edit_current_user
  get 'signup' => 'users#new', :as => :signup
  get 'logout' => 'sessions#destroy', :as => :logout
  get 'login' => 'sessions#new', :as => :login
  get 'forgot_password' => 'sessions#forgot_password', :as => :forgot_password
  get 'mail_password' => 'sessions#mail_password', :as => :mail_password
  resources :sessions
  resources :users do 
    collection do
      get 'impersonate/:username', action: :impersonate, as: :impersonate
      get 'unimpersonate', action: :unimpersonate
      get 'username/:username', action: :username
      get 'change_password', action: :change_password
      post 'change_password', action: :change_password
      post 'update_password', action: :update_password
      get 'forgot_password', action: :forgot_password
      post 'mail_password', action: :mail_password
    end
  end
  root :to => "articles#index"
end
