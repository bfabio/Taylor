Setting.create_if_not_exists(
  title:       'Remedy Enviroment Variables',
  name:        'remedy_env_vars',
  area:        'Integration::Remedy',
  description: 'Defines Enviroment variables for Remedy API calls',
  options:     {},
  frontend:    false
)
Setting.create_if_not_exists(
  title:       'Remedy Ticket\'s State Mapping',
  name:        'remedy_ticket_state_mapping',
  area:        'Integration::Remedy',
  description: 'Defines ticket\'s states mappings between Remedy and Zammad',
  options:     {},
  state:       {
      nuovo: 1,
      assegnato: 2,
      pendente: 3,
      risolto: 4,
      chiuso: 4,
      annullato: 6,
     },
  frontend:    false
)
Ticket::Article::Type.create_if_not_exists(id: 13, name: 'remedy', communication: true)
Setting.create_if_not_exists(
  title:       'Remedy Integration',
  name:        'remedy_integration',
  area:        'Integration::Switch',
  description: 'Defines if Remedy integration is enabled or not.',
  options:     {
    form: [
      {
        display: '',
        null:    true,
        name:    'remedy_integration',
        tag:     'boolean',
        options: {
          true  => 'yes',
          false => 'no',
        },
      },
    ],
  },
  state:       true,
  preferences: {
    prio:           1,
    trigger:        ['menu:render', 'cti:reload'],
    authentication: true,
    permission:     ['admin.integration'],
  },
  frontend:    true
)
Setting.create_if_not_exists(
  title:       'Remedy Config',
  name:        'remedy_config',
  area:        'Integration::Remedy',
  description: 'Defines the Remedy Integration configurations.',
  options:     {},
  state:       { 'outbound' => { 'routing_table' => [], 'default_caller_id' => '' }, 'inbound' => { 'block_caller_ids' => [] } },
  preferences: {
    prio:       2,
    permission: ['admin.integration'],
  },
  frontend:    false
)
Setting.create_if_not_exists(
  title:       'Remedy Ticket\'s Priority Mapping',
  name:        'remedy_ticket_priority_mapping',
  area:        'Integration::Remedy',
  description: 'Defines ticket\'s priorities mappings between Remedy and Zammad',
  options:     {},
  state:       {
      1 => 'Minimo/Localizzato-Bassa',
      2 => 'Moderato/Limitato-Media',
      3 => 'Significativo/Grande-Alta'
   },
  frontend:    false
)
Setting.create_if_not_exists(
  title:       'Remedy Token',
  name:        'remedy_token',
  area:        'Integration::Remedy',
  description: 'Token for Remedy.',
  options:     {
    form: [
      {
        display: '',
        null:    false,
        name:    'remedy_token',
        tag:     'input',
      },
    ],
  },
  preferences: {
    permission: ['admin.integration'],
  },
  frontend:    false
)
Setting.create_if_not_exists(
  title:       'Remedy Base URL',
  name:        'remedy_base_url',
  area:        'Integration::Remedy',
  description: 'Remedy Base URL.',
  options:     {
    form: [
      {
        display: '',
        null:    false,
        name:    'remedy_endpoint',
        tag:     'input',
      },
    ],
  },
  preferences: {
    permission: ['admin.integration'],
  },
  frontend:    false
)

Setting.find_by(name: 'Remedy_transaction').try(:destroy)

User.create_if_not_exists(
  id:              4,
  login:           'remedy.agent@zammad.org',
  firstname:       'Remedy',
  lastname:        'Agent',
  email:           'remedy.agent@zammad.org',
  password:        '',
  active:          true,
  roles:           [ Role.find_by(name: 'Agent') ]
)

Setting.create_if_not_exists(
  title:       'Remedy State Alignment',
  name:        'remedy_state_alignment',
  area:        'Integration::Remedy',
  description: 'Defines whether the aligner will align ticket states between Remedy and Zammad.',
  options:     {},
  state:       true,
  frontend:    false
)

Ticket::State.create_if_not_exists(
     id: 8,
     name: 'resolved',
     state_type: Ticket::StateType.find_by(name: 'pending action'),
     ignore_escalation: true,
     next_state: Ticket::State.find_by(name: 'closed'),
     created_by_id: 1,
     updated_by_id: 1,
)
attribute = ObjectManager::Attribute.get(
     object: 'Ticket',
     name: 'pending_time',
   )
attribute.data_option[:required_if][:state_id] = Ticket::State.by_category(:pending).pluck(:id)
attribute.data_option[:shown_if][:state_id] = Ticket::State.by_category(:pending).pluck(:id)
attribute.save!

Ticket::State.create_if_not_exists(
     id: 9,
     name: 'pending user feedback',
     state_type: Ticket::StateType.find_by(name: 'open'),
     created_by_id: 1,
     updated_by_id: 1,
)

Ticket::State.create_if_not_exists(
     id: 10,
     name: 'pending external activity',
     state_type: Ticket::StateType.find_by(name: 'open'),
     created_by_id: 1,
     updated_by_id: 1,
     external_state_id: 2,
)

attribute = ObjectManager::Attribute.get(
   object: 'Ticket',
   name: 'state_id',
 )
attribute.data_option[:filter] = Ticket::State.by_category(:viewable).pluck(:id)
attribute.screens[:create_middle]['ticket.agent'][:filter] = Ticket::State.by_category(:viewable_agent_new).pluck(:id)
attribute.screens[:create_middle]['ticket.customer'][:filter] = Ticket::State.by_category(:viewable_customer_new).pluck(:id)
attribute.screens[:edit]['ticket.agent'][:filter] = Ticket::State.by_category(:viewable_agent_edit).pluck(:id)
attribute.screens[:edit]['ticket.customer'][:filter] = Ticket::State.by_category(:viewable_customer_edit).pluck(:id)
attribute.save!







