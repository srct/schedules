# Registers all routes for the app.
Rails.application.routes.draw do
  get 'about', to: 'about#index', as: 'about'

  get '/', to: 'home#index', as: 'home'
  get 'search', to: 'search#index', as: 'search'

  resources :courses, only: [:show]
  resources :course_sections, only: [:index, :show]
  resources :instructors, only: [:show]
  get 'schedule', to: 'schedules#show', as: 'schedule'

  scope :api, module: 'api' do # Register /api routes
    resources :schedules, only: [:index], as: 'api_schedules'
  end

  root to: 'home#index'
end
