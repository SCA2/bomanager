Rails.application.routes.draw do
  root                to: 'static_pages#landing'
  get   '/home',      to: 'components#index'
  get   '/sign_in',   to: 'sessions#new'
  post  '/sign_in',   to: 'sessions#create'
  get   '/sign_out',  to: 'sessions#destroy'
  get   '/sign_up',   to: 'users#new'

  resources :users, only: [:new, :create]
  resources :categories, only: [:index, :show]
  resources :components, only: [:index, :show]
  resources :boms, only: [:index, :create, :show]
  resources :bom_items

end
