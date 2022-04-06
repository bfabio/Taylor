# Copyright (C) 2012-2021 Zammad Foundation, http://zammad-foundation.org/

Zammad::Application.routes.draw do
  api_path = Rails.configuration.api_path

  match api_path + '/features',               to: 'features#index',         via: :get
  match api_path + '/features/:id',           to: 'features#update',         via: :put
end
