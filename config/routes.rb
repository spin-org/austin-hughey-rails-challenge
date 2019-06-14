Rails.application.routes.draw do
  get '/scooters/:id', to: 'scooters#show'
  put '/scooters/:id/activate', to: 'scooters#activate'
  put '/scooters/:id/deactivate', to: 'scooters#deactivate'
end
