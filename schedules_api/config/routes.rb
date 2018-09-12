# Registers all routes for the app.
Rails.application.routes.draw do
  scope :api do # Register /api routes
    resources :courses, only: [:index, :show]
    resources :course_sections, only: [:index]
    resources :course_listing, only: [:index]
    resources :schedules, only: [:index]
  end

  apipie # sets up API docs
  get '/', to: redirect('/api') # redirect the root url to API docs
end
