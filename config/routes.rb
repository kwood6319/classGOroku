Rails.application.routes.draw do
  root to: "games#new"

  resources :games, only: [:new, :create, :show, :destroy] do
    member do
      get  :lobby
      post :start
      post :restart
    end
    resources :turns, only: [:create]
  end
end
