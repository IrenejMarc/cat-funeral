Rails.application.routes.draw do
  get 'register' => 'users#new'
  post 'register' => 'users#create'


  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'

  get 'logout' => 'sessions#destroy'

  resources :reservations do
    collection do
      get 'day', to: 'reservations#day'
    end
  end
end