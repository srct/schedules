# Registers all routes for the app.
Rails.application.routes.draw do
  scope :api do # Register /api routes
    resources :courses, only: [:index] do # GET /api/courses
      resources :sections, only: [:index] # GET /api/courses/:course_id/sections
    end

    get 'search', controller: 'search', action: 'index'
  end

  get 'home/index'
  root 'home#index' # Set the root to be the home index
end
