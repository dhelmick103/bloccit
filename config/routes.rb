Rails.application.routes.draw do
  resources :topics do
    resources :posts, except: [:index]
  end

  get 'about' => 'welcome#about'

  root 'welcome#index'

  resources :users, only: [:new, :create]
  post 'users/confirm' => 'users#confirm'
end
