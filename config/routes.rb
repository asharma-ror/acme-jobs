Rails.application.routes.draw do
  namespace :admin do
    resource :jobs, only: [:new, :create]
  end

  resources :jobs, only: [:show, :index] do
    member do
      get 'apply'
      post 'save_candidate'
      get 'candidates'
    end
  end

  root 'jobs#index'
end
