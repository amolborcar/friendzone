Friendzone::Application.routes.draw do
  get 'index', to: 'networks#index'
  get 'search', to: 'networks#search'
  get 'sign_in', to: 'networks#sign_in'
  get 'auth', to: 'networks#auth'
  root to: 'networks#index'

end
