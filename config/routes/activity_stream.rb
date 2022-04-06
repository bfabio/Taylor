# Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

Zammad::Application.routes.draw do
  api_path = Rails.configuration.api_path

  match api_path + '/activity_stream',   to: 'activity_stream#show', via: :get

end
