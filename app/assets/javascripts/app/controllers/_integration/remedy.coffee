class Index extends App.ControllerIntegrationBase
  featureIntegration: 'remedy_integration'
  featureName: 'Remedy'
  featureConfig: 'remedy_integration'
  description: [
    ['This service forwards tickets to Remedy. Since tickets can be also updated Remedy-side, a ticket aligning system should be provided.']
  ]

  render: =>
    super
    new Form(
      el: @$('.js-form')
    )

class Form extends App.Controller
  events:
    'submit form': 'update'
    'click .js-inboundBlockCallerId .js-add': 'addInboundBlockCallerId'
    'click .js-outboundRouting .js-add': 'addOutboundRouting'
    'click .js-notifyMap .js-addMap': 'addNotifyMap'
    'click .js-inboundBlockCallerId .js-remove': 'removeInboundBlockCallerId'
    'click .js-outboundRouting .js-remove': 'removeOutboundRouting'
    'click .js-notifyMap .js-removeMap': 'removeNotifyMap'

  constructor: ->
    super
    @render()

  currentConfig: ->
    config = App.Setting.get('remedy_config')
    if !config.outbound
      config.outbound = {}
    if !config.outbound.routing_table
      config.outbound.routing_table = []
    if !config.inbound
      config.inbound = {}
    if !config.inbound.block_caller_ids
      config.inbound.block_caller_ids = []
    if !config.notify_map
      config.notify_map = []
    config

  setConfig: (value) ->
    App.Setting.set('remedy_config', value, {notify: true})

  render: =>
    @config = @currentConfig()

    @html App.view('integration/remedy')(
      config: @config
      remedy_endpoint: App.Setting.get('remedy_endpoint')
      remedy_token: App.Setting.get('remedy_token')
      remedy_state_mapping: App.Setting.get('remedy_ticket_state_mapping')
    )

    # placeholder
    configure_attributes = [
      { name: 'user_ids', display: '', tag: 'column_select', multiple: true, null: true, relation: 'User', sortBy: 'firstname' },
    ]
    new App.ControllerForm(
      el: @$('.js-userSelectorBlank')
      model:
        configure_attributes: configure_attributes,
      params:
        user_ids: []
      autofocus: false
    )

    for row in @config.notify_map
      configure_attributes = [
        { name: 'user_ids', display: '', tag: 'column_select', multiple: true, null: true, relation: 'User', sortBy: 'firstname' },
      ]
      new App.ControllerForm(
        el: @$("[name=queue][value='#{row.queue}']").closest('tr').find('.js-userSelector')
        model:
          configure_attributes: configure_attributes,
        params:
          user_ids: row.user_ids
        autofocus: false
      )

  updateCurrentConfig: =>
    config = @config
    cleanupInput = @cleanupInput

    # default caller_id
    default_caller_id = @$('input[name=default_caller_id]').val()
    config.outbound.default_caller_id = cleanupInput(default_caller_id)

    # routing table
    config.outbound.routing_table = []
    @$('.js-outboundRouting .js-row').each(->
      dest = cleanupInput($(@).find('input[name="dest"]').val())
      caller_id = cleanupInput($(@).find('input[name="caller_id"]').val())
      note = $(@).find('input[name="note"]').val()
      config.outbound.routing_table.push {
        dest: dest
        caller_id: caller_id
        note: note
      }
    )

    # blocked caller ids
    config.inbound.block_caller_ids = []
    @$('.js-inboundBlockCallerId .js-row').each(->
      caller_id = $(@).find('input[name="caller_id"]').val()
      note = $(@).find('input[name="note"]').val()
      config.inbound.block_caller_ids.push {
        caller_id: cleanupInput(caller_id)
        note: note
      }
    )

    # notify map
    config.notify_map = []
    @$('.js-notifyMap .js-row').each(->
      queue = $(@).find('input[name="queue"]').val()
      user_ids = $(@).find('select[name="user_ids"]').val()
      config.notify_map.push {
        queue: cleanupInput(queue)
        user_ids: user_ids
      }
    )

    @config = config

  update: (e) =>
    e.preventDefault()
    @updateCurrentConfig()
    @setConfig(@config)

  cleanupInput: (value) ->
    return value if !value
    value.replace(/\s/g, '').trim()

  addInboundBlockCallerId: (e) =>
    e.preventDefault()
    @updateCurrentConfig()
    element = $(e.currentTarget).closest('tr')
    caller_id = element.find('input[name="caller_id"]').val()
    note = element.find('input[name="note"]').val()
    return if _.isEmpty(caller_id) || _.isEmpty(note)
    @config.inbound.block_caller_ids.push {
      caller_id: @cleanupInput(caller_id)
      note: note
    }
    @render()

  addOutboundRouting: (e) =>
    e.preventDefault()
    @updateCurrentConfig()
    element = $(e.currentTarget).closest('tr')
    dest = @cleanupInput(element.find('input[name="dest"]').val())
    caller_id = @cleanupInput(element.find('input[name="caller_id"]').val())
    note = element.find('input[name="note"]').val()
    return if _.isEmpty(caller_id) || _.isEmpty(dest) || _.isEmpty(note)
    @config.outbound.routing_table.push {
      dest: dest
      caller_id: caller_id
      note: note
    }
    @render()

  addNotifyMap: (e) =>
    e.preventDefault()
    @updateCurrentConfig()
    element = $(e.currentTarget).closest('tr')
    queue = @cleanupInput(element.find('input[name="queue"]').val())
    user_ids = element.find('select[name="user_ids"]').val()
    if _.isEmpty(queue)
      @notify(
        type:    'error'
        msg:     App.i18n.translateContent('A queue is required!')
        timeout: 6000
      )
      return
    if _.isEmpty(user_ids)
      @notify(
        type:    'error'
        msg:     App.i18n.translateContent('A user is required!')
        timeout: 6000
      )
      return

    for row in @config.notify_map
      if row.queue is queue
        @notify(
          type:    'error'
          msg:     App.i18n.translateContent('Queue already exists!')
          timeout: 6000
        )
        return
    @config.notify_map.push {
      queue: queue
      user_ids: user_ids
    }
    @render()

  removeInboundBlockCallerId: (e) =>
    e.preventDefault()
    @updateCurrentConfig()
    element = $(e.currentTarget).closest('tr')
    element.remove()
    @updateCurrentConfig()

  removeOutboundRouting: (e) =>
    e.preventDefault()
    @updateCurrentConfig()
    element = $(e.currentTarget).closest('tr')
    element.remove()
    @updateCurrentConfig()

  removeNotifyMap: (e) =>
    e.preventDefault()
    @updateCurrentConfig()
    element = $(e.currentTarget).closest('tr')
    element.remove()
    @updateCurrentConfig()

class State
  @current: ->
    App.Setting.get('remedy_integration')

App.Config.set(
  'IntegrationRemedy'
  {
    name: 'Remedy'
    target: '#system/integration/remedy'
    description: 'An external ticket-handling service.'
    controller: Index
    state: State
    permission: ['admin.integration.remedy']
  }
  'NavBarIntegrations'
)
