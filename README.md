
Rails 5 action cable chat app

Many to Many relationship: Chatrooms has many users, User has many chatrooms...chatroomuser model is the join table

needed to add jquery-rails gem as its not in there by default

The benefit of using turbolinks for the chatroom channels is that it will keep the websocket open because that is already running on the previous page 
and because this is not a browser transition page, the websocket will continue being uninterrupted.
This is really good because you wont miss out on any messages.