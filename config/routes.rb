Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#confirm'
  get 'pages/index'
  get 'pages/manage'
  
  resources :images
  resources :images do
    member do
      get 'show_image'
    end
  end
end
