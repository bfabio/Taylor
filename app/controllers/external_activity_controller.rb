require 'base64'

class ExternalActivityController < ApplicationController

  prepend_before_action { authentication_check && authorize! }

  def index_external_activity
    return if !params[:ticketing_system_id]
    system = ExternalTicketingSystem.find_by(id: params[:ticketing_system_id])
    external_activities = ExternalActivity.where(external_ticketing_system_id: params[:ticketing_system_id])
    external_activities = external_activities.where(ticket_id: params[:ticket_id]) if params[:ticket_id].present? && params[:ticket_id] != ''
    external_activities = external_activities.where(archived: params[:archived]) if params[:archived].present? && params[:archived] != ''
    external_activities = external_activities.where(delivered: params[:delivered]) if params[:delivered].present? && params[:delivered] != ''
    external_activities.each do |external_activity|
      external_activity.data = process_attachments system.model, external_activity.data, external_activity, true
    end
    render json: external_activities
  end

  def show_external_activity
    external_activity = ExternalActivity.find_by(id: params[:id])
    system = ExternalTicketingSystem.find_by(id: external_activity.external_ticketing_system_id)
    external_activity.data = process_attachments system.model, external_activity.data, external_activity, true
    render json: external_activity
  end

  def create_external_activity
    return if !params[:ticketing_system_id]
    return if !params[:ticket_id]


    system = ExternalTicketingSystem.find_by(id:params[:ticketing_system_id])
    data = process_attachments system.model, params.permit!.to_h["data"], nil

    external_activity = ExternalActivity.create(
      external_ticketing_system_id: params[:ticketing_system_id],
      ticket_id:                    params[:ticket_id],
      data:                         data,
      bidirectional_alignment:      params[:bidirectional_alignment],
      updated_by_id:                current_user.id,
      created_by_id:                current_user.id,
    )
    render json: external_activity
  end

  def update_external_activity
    return if !params[:id]

    external_activity = ExternalActivity.find_by(id: params[:id])
    return if !external_activity

    #checking update grants for current user
    can_update = false
    system = ExternalTicketingSystem.find_by(id:external_activity.external_ticketing_system_id)
    access = Setting.find_by(name:"external_activity_group_access").state_current[:value]
    current_user.groups.each do |group|
      if access[system.name]
        permission = access[system.name]["group_"+group.id.to_s]
        if permission == "rw"
          can_update = true
          break
        end
      end
    end
    return if !can_update


    new_values = params[:data]
    if new_values
      system.model.each do |_index, field|
        if field['notify_changes'] && !new_values[field["name"]].eql?(external_activity.data[field["name"]])
          external_activity.needs_attention = true
          Role.where(name: 'Agent').first.users.where(active: true).each do |agent|
            OnlineNotification.add(
              type:          'external_activity',
              object:        'Ticket',
              o_id:          external_activity.ticket_id,
              seen:          false,
              created_by_id: 1,
              user_id:       agent.id,
            )
          end
          break
        end
      end
    end

    data = process_attachments system.model, params.permit!.to_h["data"], external_activity

    external_activity.data = data if data && external_activity.data != data
    external_activity.archived = stop_monitoring? external_activity
    external_activity.delivered = params[:delivered] if !params[:delivered].nil?

    external_activity.save!
    render json: external_activity
  end

  def process_attachments (model, data, external_activity, decode = false)
    model.each do |index, field|
      next if !field['type'].eql? 'comment' || !data[field['name']]
      comment_index = 0
      data[field['name']].each do |comment|
        next if !comment['attachments']
        comment['attachments'].each do |index, attachment|
          if decode
            #attachment["file"] = Base64.decode64(attachment["file"])
          else
            if attachment['to_encode']
              #Rails.logger.info "FILE:"
              #Rails.logger.info attachment["file"]
              #attachment["file"] = Base64.encode64(attachment["file"]).force_encoding('utf-8')
              #attachment.delete(:to_encode)
            elsif external_activity
              #attachment["file"] = external_activity.data[field["name"]][comment_index]["attachments"][index.to_s]["file"]
            end
          end
        end
        comment_index = comment_index+1
      end
    end
    data
  end

  def stop_monitoring? (external_activity)
    stop_monitoring = false
    system = ExternalTicketingSystem.find_by(id: external_activity.external_ticketing_system_id)
    system.model.each do |_index, field|
      next if !field['stop_monitoring']

      if field['stop_monitoring'].include?(external_activity.data[field['name']])
        stop_monitoring = true
      end
    end
    stop_monitoring
  end

  def index_external_ticketing_system
    systems = ExternalTicketingSystem.all
    systems = systems.where(name: params[:name]) if params[:name].present? && params[:name] != ''
    access = Setting.find_by(name:"external_activity_group_access").state_current[:value]
    systems_with_permissions = []
    groups = current_user.groups
    current_user.roles.each do |role|
      groups += role.groups
    end
    systems.each do |system|

      groups.each do |group|
        if access[system.name]
          permission = access[system.name]["group_"+group.id.to_s]
          if permission == "r" || permission == "rw"
            json_system = system.as_json
            json_system[:permission] = permission
            if params[:ticket]
              activities = ExternalActivity.where(ticket_id: params[:ticket], external_ticketing_system_id: system.id)
              json_system[:activities_needing_attention] = activities.select {|activity| activity.needs_attention}.length
            end
            systems_with_permissions << json_system
            break
          end
        end
      end
    end
    render json: systems_with_permissions
  end

  def show_external_ticketing_system
    render json: ExternalTicketingSystem.find_by(id: params[:id])
  end

  def create_external_ticketing_system
    external_ticketing_system = ExternalTicketingSystem.create(
      name:      params[:name],
      model:     params[:model],
      icon_path: params[:icon]
    )
    external_ticketing_system.save!
    render json: external_ticketing_system
  end

  def external_ticketing_system_settings
    system = ExternalTicketingSystem.find_by(id: params[:id])
    system_name = system.name.parameterize.underscore.downcase
    render json: {
      integration_enabled: Setting.get(system_name+'_integration'),
      state_alignment: Setting.get(system_name+'_state_alignment'),
      coordinates: {
        base_url: Setting.get(system_name+'_base_url'),
        token: Setting.get(system_name+'_token')
      }
    }
  end
end
