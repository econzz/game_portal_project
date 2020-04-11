Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root "fronts#index";

  get "detail" => "fronts#detail"
  get 'admin' => 'admins#index'

  get 'admin/top' => "admins#top"
  get 'admin/games' => "games#index"

end
