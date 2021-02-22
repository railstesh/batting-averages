Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :batting_averages, only: %i[index new] do
    collection do
      post :import_csv_data
    end
  end
  root 'batting_averages#index'
end
