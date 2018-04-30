# Registers all routes for the app.
Rails.application.routes.draw do
  scope :api do # Register /api routes
    resources :courses, only: [:index] do # GET /api/courses
      resources :sections, only: [:index] # GET /api/courses/:course_id/sections
    end

    get 'search', controller: 'search', action: 'index'
  end

  root 'courses#index' # Set the root to be the courses API endpoint
end
