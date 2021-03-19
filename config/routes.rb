Rails.application.routes.draw do
  resources :reservations
  resources :venues do
    collection do
      post :import
    end
  end
  get 'venue_layouts/create'
  resources :movies
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
