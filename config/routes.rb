Rails.application.routes.draw do
  resources :tools_categories do
    resources :tools
  end
end
