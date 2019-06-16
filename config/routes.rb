Rails.application.routes.draw do
  get  '/scooters/:id', to: 'scooters#show'
  put  '/scooters/:id/activate', to: 'scooters#activate'
  put  '/scooters/:id/deactivate', to: 'scooters#deactivate'
  put  '/scooters/mass-activate', to: 'scooters#mass_activate'
  get  '/scooters/near/:lat/:lon/:radius', to: 'scooters#locate'
  post '/reports', to: 'reports#create'
  get  '/reports/:scooter_id', to: 'reports#by_scooter'
  post '/tickets', to: 'tickets#create'
  get  '/tickets/:id', to: 'tickets#show'
  # Normally I'd put something like /tickets/scooter_id here too
end
