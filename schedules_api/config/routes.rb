# Registers all routes for the app.
Rails.application.routes.draw do
  scope :api do # Register /api routes
    resources :courses, only: [:index, :show]
    resources :course_sections, only: [:index]

    post 'generate', controller: 'calendar_generator', action: 'generate'
  end

  root 'courses#index' # Set the root to be the courses API endpoint
end
