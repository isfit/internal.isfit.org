InternalIsfitOrg::Application.routes.draw do


  resources :applicants do
    collection do 
      get 'statistics'
    end
  end

#  scope "(/:tab)"do   
    resources :internal_tabs do 
      collection do
        post 'get_actions'
      end
    end
    resources :static_pages
    resources :articles
    match 'user/edit' => 'users#edit', :as => :edit_current_user
    match 'signup' => 'users#new', :as => :signup
    match 'logout' => 'sessions#destroy', :as => :logout
    match 'login' => 'sessions#new', :as => :login
    resources :sessions
    resources :users
    root :to => "articles#index"
#  end
end
