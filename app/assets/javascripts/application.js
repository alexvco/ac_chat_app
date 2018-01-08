// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require turbolinks
//= require bootstrap
//= require_tree .


function handleVisibilityChange() {
  var $strike = $(".strike");
  if ($strike.length > 0) {
    var chatroom_id = $("[data-behavior='messages']").data("chatroom-id");
    App.last_read.update(chatroom_id);
    $strike.remove(); //removes from the DOM
  }
}


$(document).on("turbolinks:load", function() {

  $(document).on("click", function(){
    handleVisibilityChange();
  });

  if (Notification.permission == 'default') {
    Notification.requestPermission();
  }



  $('#new_message').on('keypress', function(e) {
    console.log(e.keyCode);
    if (e && e.keyCode == 13) {
      // alert(e.currentTarget); // this will point to the form itself, i think in this case currentTarget is the same as $(this)
      e.preventDefault();
      $(this).submit();
    }
  })

  $('#new_message').on("submit", function(e){
    e.preventDefault();
    var chatroom_id = $("[data-behavior='messages']").data("chatroom-id");
    var body        = $("#message_body");

    App.chatrooms.send_message(chatroom_id, body.val()); // this is basically calling send_message in chatrooms.coffee which is then calling send_message in chatrooms_channels.rb, so we are passing data from the front end to the server and performing MessageRelayJob.perform_later(message) in the server side, which is then broadcasting that to the appropriate channel/chatroom and rendering the message.
    body.val(""); // reset the body value when submitted
  })

});