Friendzone::Application.routes.draw do
  get 'index', to: 'networks#index'
  post 'search', to: 'networks#search'
  get 'sign_in', to: 'networks#sign_in'
  get 'sign_out', to: 'networks#sign_out'
  get 'auth', to: 'networks#auth'
  get 'load', to: 'networks#load'
  get 'find_all_names', to: 'networks#find_all_names'
  root to: 'networks#index'

end
