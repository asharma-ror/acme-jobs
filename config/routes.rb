Rails.application.routes.draw do
  require 'sidekiq/web'

  namespace :admin do
    resource :jobs, only: [:new, :create]
  end

  resources :jobs, only: [:show, :index] do
    resources :applicants, only: [:index, :new, :create]
  end

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_USERNAME'])) &&
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_PASSWORD']))
  end

  mount Sidekiq::Web => '/sidekiq'
  root 'jobs#index'
end
