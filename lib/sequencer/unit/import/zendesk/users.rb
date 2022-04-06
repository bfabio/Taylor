# Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

class Sequencer
  class Unit
    module Import
      module Zendesk
        class Users < Sequencer::Unit::Import::Zendesk::SubSequence::Object
          include ::Sequencer::Unit::Import::Zendesk::Mixin::IncrementalExport

          uses :organization_map, :group_map, :user_group_map

          private

          def default_params
            super.merge(
              organization_map: organization_map,
              group_map:        group_map,
              user_group_map:   user_group_map,
            )
          end
        end
      end
    end
  end
end
