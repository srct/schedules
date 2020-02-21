# Registers all routes for the app.
#
# This stuff is wacky magic. For an in depth guide
# to what the heck is going on, check out
# "Rails Routing from the Outside In": https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do

  # GET schedules.gmu.edu routes to HomeController#index
  get '/', to: 'home#index', as: 'home'

  # GET schedules.gmu.edu/search routes to SearchController#index
  get 'search', to: 'search#index', as: 'search'

  # GET schedules.gmu.edu/search routes to AboutController#index
  get 'about', to: 'about#index', as: 'about'

  # GET schedules.gmu.edu/schedule routes to SchedulesController#show
  get 'schedule', to: 'schedules#index', as: 'schedule'
  get 'schedule/sections', to: 'schedules#sections'

  # GET schedules.gmu.edu/courses/:id routes to CoursesController#show
  resources :courses, only: [:show]

  # GET schedules.gmu.edu/courses_sections/:id routes to CourseSectionsController#show
  #    - this is for viewing the ratings for that section
  resources :course_sections, only: [:show]

  # GET schedules.gmu.edu/instructors/:id routes to InstructorsController#show
  resources :instructors, only: [:show]

  # Register /api routes
  scope :api, module: 'api' do
    # Renders the iCal for calendar subscriptions
    resources :schedules, only: [:index], as: 'api_schedules'
  end

  # Set the home route as the root. Not sure if necessary but why not.
  root to: 'home#index'
end
