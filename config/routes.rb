Rails.application.routes.draw do
  root                to: 'static_pages#landing'
  get   '/home',      to: 'components#index'
  get   '/sign_in',   to: 'sessions#new'
  post  '/sign_in',   to: 'sessions#create'
  get   '/sign_out',  to: 'sessions#destroy'
  get   '/sign_up',   to: 'users#new'
  post  '/bom_items/:id',  to: 'bom_items#update_bom'

  resources :users, only: [:new, :create]
  resources :categories, only: [:index, :show]
  resources :components, only: [:index, :show]
  resources :boms, only: [:index, :create, :show, :destroy]
  resources :bom_items, only: [:index, :create, :destroy]

end
