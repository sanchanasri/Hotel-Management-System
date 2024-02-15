Rails.application.routes.draw do
  
  devise_for :users


  root 'hotels#index'
  resources :hotels do
    resources :items do
      resources :ratings
    end
  end
  get 'search' ,to: "hotels#search", as: "search"
  

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
