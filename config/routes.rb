Friendzone::Application.routes.draw do
  get 'index', to: 'networks#index'
  post 'search', to: 'networks#search'
  get 'sign_in_twitter', to: 'networks#sign_in_twitter'
  get 'sign_in_facebook', to: 'networks#sign_in_facebook'
  get 'sign_out', to: 'networks#sign_out'
  get 'auth_twitter', to: 'networks#auth_twitter'
  get 'load_twitter', to: 'networks#load_twitter'
  get 'auth_facebook', to: 'networks#auth_facebook'
  get 'load_facebook', to: 'networks#load_facebook'
  get 'find_all_names', to: 'networks#find_all_names'
  root to: 'networks#index'

end
