Role.create_if_not_exists(
  name:              'Admin',
  note:              'To configure your system.',
  preferences:       {},
  default_at_signup: false,
  updated_by_id:     1,
  created_by_id:     1
)
Role.create_if_not_exists(
  name:              'Agent',
  note:              'To work on Tickets.',
  default_at_signup: false,
  preferences:       {},
  updated_by_id:     1,
  created_by_id:     1
)
Role.create_if_not_exists(
  name:              'Customer',
  note:              'People who create Tickets ask for help.',
  preferences:       {},
  default_at_signup: true,
  updated_by_id:     1,
  created_by_id:     1
)
