# Registers all routes for the app.
Rails.application.routes.draw do
  get 'search', to: 'search#index'
  get 'sessions/update', as: 'update_session'
  get 'sessions/cart'

  resources :courses, only: [:show]
  resources :instructors, only: [:index, :show]
  get 'schedule', to: 'schedules#show', as: 'schedule'

  scope :api, module: 'api' do # Register /api routes
    resources :courses, only: [:index, :show], as: 'api_courses'
    resources :course_sections, only: [:index], as: 'api_course_sections'
    resources :instructors, only: [:index, :show], as: 'api_instructors'
    resources :course_listings, only: [:index]
    resources :schedules, only: [:index]
  end

  apipie # sets up API docs

  root to: 'home#index'
end
