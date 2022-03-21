# Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

class Issue3759CacheClear < ActiveRecord::Migration[6.0]
  def change
    return if !Setting.exists?(name: 'system_init_done')

    Cache.clear
  end
end
