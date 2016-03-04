Rails.application.routes.draw do
  root 'home#index'

  namespace :auth do
    get '/:provider/callback' => :callback
  end

  resources :calendar_reports, only: [:index, :create, :show, :update] do
    resources :event_summaries, only: :index, defaults: {format: :json}
  end

  get 'terms' => 'docs#terms'
end
