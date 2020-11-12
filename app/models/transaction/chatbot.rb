class Transaction::Chatbot

  def initialize(item, params = {})
    @item = item
    @params = params
  end

  def perform
    return if Setting.get('import_mode') || !Setting.get('chatbot_status')
    if @item[:object] == 'Chat Session'
      chatbot = User.find_by(login: 'chatbot@zammad.org')
      chat_session = @item[:chat_session]
      client_id = 333
      clients = [@item[:client_id],client_id]
      params = {
        session: {
          "id" => chatbot.id
        },
        payload: {
          "agent" => chatbot,
          "chat_id" => chat_session.chat_id
        },
        client_id: client_id,
        clients: clients
      }
      event = Sessions::Event::ChatSessionStart.new(params)
      result = event.run
      event.destroy
      welcome_message = ChatbotService.answerTo("/get_started")
      sendMessageToClient(chat_session.id,welcome_message,clients)
    elsif @item[:object] == 'Chat Message'
      message = Chat::Message.find_by(id: @item[:object_id])
      chat_session = Chat::Session.find_by(id: message[:chat_session_id])
      if !chat_session.stop_chatbot
        created_by = message[:created_by_id]
        reply = ChatbotService.answerTo(message.content)
        if(reply['@handoff'])
          performHandoff(chat_session)
        else
          sendMessageToClient(message[:chat_session_id],reply)
        end
      end
    end
  end

  private

  def performHandoff(chat_session)
    chat_session.stop_chatbot = true
    chat_session.save!
    chatbot = User.find_by(login: 'chatbot@zammad.org')
    params = {
      session: {
        "id" => chatbot.id
      },
      payload: {
        "session_id" => chat_session.id,
        "chat_id" => chat_session.chat_id
        },
      clients: @item[:clients]
      }
    event = Sessions::Event::ChatbotTransfer.new(params)
    result = event.run
    event.destroy
  end

  def sendMessageToClient(session_id,text,clients=nil)
    chatbot = User.find_by(login: 'chatbot@zammad.org')
    chat_message = Chat::Message.create(
      chat_session_id: session_id,
      content:         text,
      created_by_id:   chatbot.id,
    )
    message_to_send = {
      event: 'chat_session_message',
      data:  {
        session_id: session_id,
        message:    chat_message
      },
    }

    clients = clients ? clients : @item[:clients]
    # send to participents
    clients.each do |client_id,client|
      Sessions.send(client_id,message_to_send)
    end
    chat_ids = Chat.agent_active_chat_ids(chatbot)
    # broadcast new state to agents
    Chat.broadcast_agent_state_update(chat_ids)
  end

end
