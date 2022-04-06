# Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

require 'zammad/application/initializer/db_preflight_check/base'
require 'zammad/application/initializer/db_preflight_check/mysql2'
require 'zammad/application/initializer/db_preflight_check/postgresql'
require 'zammad/application/initializer/db_preflight_check/nulldb'

module Zammad
  class Application
    module Initializer
      module DbPreflightCheck
        def self.perform
          adapter.perform
        end

        def self.adapter
          @adapter ||= const_get(ActiveRecord::Base.connection_config[:adapter].capitalize)
        end
      end
    end
  end
end
