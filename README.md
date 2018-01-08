
Rails 5 action cable chat app

Many to Many relationship: Chatrooms has many users, User has many chatrooms...chatroomuser model is the join table

needed to add jquery-rails gem as its not in there by default

The benefit of using turbolinks for the chatroom channels is that it will keep the websocket open because that is already running on the previous page 
and because this is not a browser transition page, the websocket will continue being uninterrupted.
This is really good because you wont miss out on any messages.


Action Cable

First you need to make your form ajax, so add remote true.
This is actually going to work seamlessly with the JavaScript that comes from rails_ujs.
And the code that we wrote to listen to the Enter key will actually submit it and the Ajax request that rails_ujs does will automatically handle all of that.
You can see in your rails logs that this is submitted as a Javascript request.
You can also see it in chrome network tab once you press enter and the message is sent.
Chrome network tab -> messages -> Turbolinks.visit("http://localhost:3000/chatrooms/3", {"action":"replace"})
So basically it is not really doing a redirect like we have in our messages controller create actions, its using turbolinks visit which is also reloading the new messages
It works nicely, but what we want is to submit this to the server and have websockets injected into the page so no need to do a refresh for other users (even turbolinks isnt good enough in this case)
So we will comment out the redirect_to @chatroom in our messages controller show action

We need to create app/views/messages/create.js.erb




