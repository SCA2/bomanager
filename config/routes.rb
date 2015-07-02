Rails.application.routes.draw do
  root                to: 'static_pages#landing'
  get   '/home',      to: 'components#index'
  get   '/sign_in',   to: 'sessions#new'
  post  '/sign_in',   to: 'sessions#create'
  get   '/sign_out',  to: 'sessions#destroy'
  get   '/sign_up',   to: 'users#new'
  
  get   '/boms/:id',  to: 'bom_items#index'
  post  '/boms/:id',  to: 'bom_items#update_bom'

  get   '/categories/:id',  to: 'components#sub_index'

  resources :users, only: [:new, :create]
  resources :categories, only: [:show]
  resources :components, only: [:index, :show]
  resources :boms, only: [:index, :create, :destroy]
  resources :bom_items, only: [:index, :destroy]

end
