Rails.application.routes.draw do


  get 'comments/update'
  get 'comments/delete'

  resources :categories, :path => "/admin/categories"

  namespace 'api' do
    namespace 'v1' do
      get root :to => "pinterfaces#index"
      post root :to => "pinterfaces#token"

      get ":game_id/ranking_total/:page" => "pinterfaces#ranking_total"
      post ":game_id/register_score" => "pinterfaces#register_score"
      post ":game_id/add_score" => "pinterfaces#addition_score"

      post "player/:player_id" => "pinterfaces#register_player"
      get "player/:player_id" => "pinterfaces#retrieve_player"
    end
  end

  resources :games, :path => "/admin/games"
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root "fronts#index";

  get "list/category/:cid" => "fronts#category",:as => 'fronts_category'


  get "detail/:id" => "fronts#detail",:as => 'detail'

  post "detail/:id" => "fronts#newcomment"

  get "detail/:id/play" => "fronts#play",:as => 'play'
  
  
  get 'admin' => 'admins#index'

  post 'admin' => 'sessions#create'
  get "admin/logout" => "sessions#destroy"

  get 'admin/top' => "admins#top"
  

  

end
