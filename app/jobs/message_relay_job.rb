class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "chatrooms:#{message.chatroom.id}", {
      message: MessagesController.render(message), # this will render messages/_message.html.erb
      chatroom_id: message.chatroom.id # this is important because it depends which chatroom you are currently viewing, do we display the message? or do we send a notification saying you have a message in one of the other chatrooms
    }
  end
end
