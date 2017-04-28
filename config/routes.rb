Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#confirm'
  get 'pages/index'
  get 'pages/manage'
  
  get 'dictionaries/markov_dic'
  
  get 'emotions/em_dic'
  get 'emotions/analysis'
  
  resources :dictionaries, only: [:create, :destroy, :show, :index, :new, :edit, :update]
  resources :users
  resources :users do
    member do
      get 'show_image1'
      get 'show_image2'
      get 'show_image3'
      get 'show_image4'
      get 'show_image5'
      get 'show_evo'
    end
  end

  resources :images
  resources :images do
    member do
      get 'show_image'
    end
  end
end
