# Registers all routes for the app.
Rails.application.routes.draw do
  get 'search', to: 'search#index'
  get 'search/add/:id', to: 'search#add'
  get 'search/remove/:id', to: 'search#remove'

  scope :api do # Register /api routes
    resources :courses, only: [:index, :show]
    resources :course_sections, only: [:index]
    resources :schedules, only: [:index]
  end

  apipie # sets up API docs
  get '/', to: redirect('/api') # redirect the root url to API docs
end
