# Registers all routes for the app.
Rails.application.routes.draw do
  get 'search', to: 'search#index'
  get 'search/update', to: 'search#update'

  scope :api do # Register /api routes
    resources :courses, only: [:index, :show]
    resources :course_sections, only: [:index]
    resources :schedules, only: [:index]
  end

  apipie # sets up API docs

  root to: 'home#index'
end
