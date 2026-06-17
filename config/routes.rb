Rails.application.routes.draw do
  root to: "games#new"

  resources :games, only: [:new, :create, :show, :destroy] do
    member do
      get  :lobby
      post :start
    end
    resources :turns, only: [:create]
  end
end
