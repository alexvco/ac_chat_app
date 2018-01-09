class Chatroom < ApplicationRecord
  has_many :chatroomusers, dependent: :destroy
  has_many :users, through: :chatroomusers
  has_many :messages, dependent: :destroy


  scope :public_channels, ->{ where(direct_message: false) }
  scope :direct_messages, ->{ where(direct_message: true) }

  def self.direct_message_for_users(users)
   user_ids = users.map(&:id).sort #basically returns out array of id's and sorts them
   name = "DM:#{user_ids.join(":")}" #creates chatroom name based on id's 

   if chatroom = direct_messages.where(name: name).first
     chatroom
   else
     # create a new chatroom
     chatroom = new(name: name, direct_message: true)
     chatroom.users = users
     chatroom.save
     chatroom
   end
  end

end
