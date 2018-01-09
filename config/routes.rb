Rails.application.routes.draw do

  mount ActionCable.server => "/cable"
  
  resources :chatrooms do
    resource :chatroomusers, only: [:create, :destroy]
    resources :messages
  end

# if you do resources this is the routes you get 

  #                 Prefix   Verb     URI Pattern                                           Controller#Action
  # chatroom_chatroomusers   POST     /chatrooms/:chatroom_id/chatroomusers(.:format)       chatroomusers#create
  #  chatroom_chatroomuser   DELETE   /chatrooms/:chatroom_id/chatroomusers/:id(.:format)   chatroomusers#destroy




# if you do resource this is the routes you get, which is what you want because you dont want to delete a join table record like that, you should delete the chatroom or the user. 

  #                 Prefix   Verb     URI Pattern                                           Controller#Action
  # chatroom_chatroomusers   DELETE   /chatrooms/:chatroom_id/chatroomusers(.:format)       chatroomusers#destroy
  #                          POST     /chatrooms/:chatroom_id/chatroomusers(.:format)       chatroomusers#create

  devise_for :users
  root 'chatrooms#index'
end
