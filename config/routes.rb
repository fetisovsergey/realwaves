Rails.application.routes.draw do
resources :sessions, only: [:new, :create, :destroy]
resources :users do
    member do
      get :manage, :new_post, :users, :confirm_email
    end
  end

resources :products do
	member do
      put "upvote", to: "products#upvote"
      put "downvote", to: "products#downvote"
      put "deactivate", to: "products#deactivate"
      put "activate", to: "products#activate"
      get :votes
     end
 end


root to: 'static_pages#home'

#Маршруты для разных разделов
match '/style', to: 'static_pages#style', via: 'get'
match '/movies_and_music', to: 'static_pages#movies_and_music', via: 'get'
match '/vehicle', to: 'static_pages#vehicle', via: 'get'
match '/tech', to: 'static_pages#tech', via: 'get'
match '/sport', to: 'static_pages#sport', via: 'get'
match '/stuff', to: 'static_pages#stuff', via: 'get'
####################################################

match '/rules', to: 'static_pages#rules', via: 'get'
match '/search', to: 'static_pages#search', via: 'get'
match '/error', to: 'static_pages#error', via: 'get'
match '/email', to: 'static_pages#email', via: 'get'
match '/sessions', to: 'static_pages#home', via: 'get'
match '/signup', to: 'users#new',            via: 'get'
match '/signin',  to: 'sessions#new',         via: 'get'
match '/signout', to: 'sessions#destroy',     via: 'delete'
match '/about',   to: 'static_pages#about',   via: 'get'
match '/contact', to: 'static_pages#contact', via: 'get'
end
