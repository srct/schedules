# Registers all routes for the app.
Rails.application.routes.draw do
  scope :api do # Register /api routes
    resources :courses, only: [:index, :show]
    resources :course_sections, only: [:index]
    resources :schedules, only: [:index]
  end

  get '/', to: redirect('/api')
end
