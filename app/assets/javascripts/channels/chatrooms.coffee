App.chatrooms = App.cable.subscriptions.create "ChatroomsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log data
    # Called when there's incoming data on the websocket for this channel
    # when you console.log data, you get this: {message: "<div><strong>av:</strong> asdf</div>↵", chatroom_id: 4}
    # which is exaclty what we passed in jobs/message_relay_job.rb

    # usually you would do something like this here:
    # $("[data-behavior='messages']").append(data.message)
    # however in our case, that would append the data.message to all the chatrooms which is not what we want
    # we want to append the data.message only to the chatroom we send the message to.
    active_chatroom = $("[data-behavior='messages'][data-chatroom-id='#{data.chatroom_id}']")
    if active_chatroom.length > 0
      active_chatroom.append(data.message)
    else
      $("[data-behavior='chatroom-link'][data-chatroom-id='#{data.chatroom_id}']").css("font-weight", "bold")
    # So basically what this does is that it makes the other chatrooms bold when they receive a message, while you are in a chatroom
 