Rails.application.routes.draw do
  namespace :admin do
    resource :jobs, only: [:new, :create]
  end

  resources :jobs, only: [:show, :index]

  root 'jobs#index'
end
