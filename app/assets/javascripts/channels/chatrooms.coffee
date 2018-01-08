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
      active_chatroom.append("<div><strong>#{data.username}:</strong> #{data.body}</div>")
      # this is when you are on another tab/website and you receive a message on the channel you are currently on in our website tab
      if document.hidden && Notification.permission == "granted"
        new Notification(data.username, {body: data.body})
    else
    # So basically what this does is that it makes the other chatrooms bold when they receive a message, while you are in a chatroom and also sends a notification in your browser
      $("[data-behavior='chatroom-link'][data-chatroom-id='#{data.chatroom_id}']").css("font-weight", "bold")
      if Notification.permission == "granted"
        new Notification(data.username, {body: data.body})
  
  send_message: (chatroom_id, message) ->
    @perform "send_message", {chatroom_id: chatroom_id, body: message}

    # We'll send over this JSON object, and so the server side will receive that in
    # app/channels/chatrooms_channel.rb

    # So this @perform is calling send_message and we'll have some data that we receive which will be this JSON object here. 
    # We'll have this set up so that we can perform that send message function server side, and we can just pass that data over, 
    # and ActionCable is going to know what to do, it will convert it to the ruby function. 
    # It will call that function, it will execute that server side and do whatever you want. 
    # That means all we have to do now is:

    # application.js

      #  App.chatrooms.send_message(chatroom_id, body.val())