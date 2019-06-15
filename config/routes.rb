Rails.application.routes.draw do
  get '/scooters/:id', to: 'scooters#show'
  put '/scooters/:id/activate', to: 'scooters#activate'
  put '/scooters/:id/deactivate', to: 'scooters#deactivate'
  put '/scooters/mass-activate', to: 'scooters#mass_activate'
  post '/reports', to: 'reports#create'
  post '/tickets', to: 'tickets#create'
  get  '/tickets/:id', to: 'tickets#show'
  # Normally I'd put something like /tickets/scooter_id here too
end
