Rails.application.routes.draw do
  resources :games, :path => "/admin/games"
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root "fronts#index";

  get "detail/:id" => "fronts#detail",:as => 'detail'

  get "detail/:id/play" => "fronts#play",:as => 'play'
  
  get 'admin' => 'admins#index'

  post 'admin' => 'sessions#create'
  get "admin/logout" => "sessions#destroy"

  get 'admin/top' => "admins#top"
  

  

end
