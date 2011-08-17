InternalIsfitOrg::Application.routes.draw do


#  scope "(/:tab)"do   
    resources :internal_tabs
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
#  end
end
