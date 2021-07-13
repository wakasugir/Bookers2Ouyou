Rails.application.routes.draw do
  get 'emails/new'
  get 'emails/show'
	devise_for :users, controllers: {
    sessions: "public/sessions",
    registrations: "public/registrations"
  }

  resources :users,only: [:show,:edit,:update,:index] do
    member do
      get 'followers'
      get 'followings'
    end
    resource :relationships, only: [:create, :destroy]
  end
  
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create]
  end

  resources :book_comments, only: [:destroy]

  root 'home#top'
  get 'home/about'
  
  resources :groups
  post 'groups/:id/join' => "groups#join", as: :group_join
  delete 'groups/:id/leave' => "groups#leave", as: :group_leave
  
  resources :emails, only: [:new, :show, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
