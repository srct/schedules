# Registers all routes for the app.
Rails.application.routes.draw do
  get '/', to: 'home#index', as: 'home'
  get 'search', to: 'search#index', as: 'search'
  get 'sessions/update', as: 'update_session'
  get 'sessions/cart'
  get 'sessions/add_bulk'

  resources :courses, only: [:show]
  resources :course_sections, only: [:show]
  resources :instructors, only: [:index, :show]
  get 'schedule', to: 'schedules#show', as: 'schedule'
  get 'schedule/view', to: 'schedules#view', as: 'view_schedule'

  scope :api, module: 'api' do # Register /api routes
    resources :semesters, only: [:index], as: 'api_semesters'
    resources :courses, only: [:index, :show], as: 'api_courses'
    resources :course_sections, only: [:index], as: 'api_course_sections'
    resources :instructors, only: [:index, :show], as: 'api_instructors'
    resources :course_listings, only: [:index]
    resources :schedules, only: [:index], as: 'api_schedules'
  end

  apipie # sets up API docs

  root to: 'home#index'
end
