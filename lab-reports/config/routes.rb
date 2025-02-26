Rails.application.routes.draw do
  resources :users
  resources :lab_reports
  root "lab_reports#index"
end
