Rails.application.routes.draw do
  resources :courses, only: [:index] do
    resources :sections, only: [:index]
  end

  root 'courses#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
