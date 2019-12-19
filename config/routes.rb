# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users
    resources :movies do
      resources :reviews, except: %i[show index]
    end
    root 'movies#index'
  end

end
