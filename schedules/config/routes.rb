# Registers all routes for the app.
Rails.application.routes.draw do
  get 'search', to: 'search#index'
  get 'search/update', to: 'search#update'

  resources :instructors, only: [:index, :show]

  scope :api do # Register /api routes
    resources :courses, only: [:index, :show]
    resources :course_sections, only: [:index]
    resources :instructors, only: [:index, :show]
    resources :schedules, only: [:index]
  end

  apipie # sets up API docs

  root to: 'home#index'
end
