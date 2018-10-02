# Registers all routes for the app.
Rails.application.routes.draw do
  get 'search', to: 'search#index'
  get 'sessions/update', as: 'update_session'
  
  resources :instructors, only: [:index, :show]

  scope :api do # Register /api routes
    resources :courses, only: [:index, :show]
    resources :course_sections, only: [:index]
    resources :instructors, only: [:index, :show]
    resources :course_listings, only: [:index]
    resources :schedules, only: [:index]
  end

  apipie # sets up API docs

  root to: 'home#index'
end
