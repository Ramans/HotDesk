Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    scope "(:locale)", :locale => /en|zh/ do
        
      	resources :users do
            collection do
                get "login"
                post "login"
                get "logout"
                get "cancel_seat"
            end
        end

        match '/' => 'users#index', via: [:get]
        
        match '/login' => 'users#login', via: [:get, :post]
        match '/logout' => 'users#logout', via: [:get]
        
        match '*a', :to => 'errors#routing', via: :all
    end

end
