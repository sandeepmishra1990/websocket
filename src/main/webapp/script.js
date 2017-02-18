
	var wsocket;
	var serviceLocation = "ws://localhost:8080/testsocket/chatwithme/";
	var $nickName;
	var $message;
	var $chatWindow;
	var room = '';
 
	function onMessageReceived(evt) {
		//var msg = eval('(' + evt.data + ')');
		var msg = JSON.parse(evt.data); // native API
		if((msg.sender)===$nickName.val()){
		var $messageLine = $('<tr height="25x"><td class="received">' + msg.received
				+ '</td><td class="user label label-info">' + msg.sender
				+ '</td><td class="message badge">' + msg.message
				+ '</td></tr>');
				} else{
				var $messageLine = $('<tr height="25x"><td class="received">' + msg.received
				+ '</td><td class="user label label-success">' + msg.sender
				+ '</td><td class="message badge">' + msg.message
				+ '</td></tr>');
				
				}
				
		$chatWindow.append($messageLine);
	}
	function sendMessage() {
		var msg = '{"message":"' + $message.val() + '", "sender":"'
				+ $nickName.val() + '", "received":""}';
		wsocket.send(msg);
		$message.val('').focus();
	}
 
	function connectToChatserver() {
		room = $('#chatroom option:selected').val();

		wsocket = new WebSocket(serviceLocation + room);
		wsocket.onmessage = onMessageReceived;
	}
 
	function leaveRoom() {
		wsocket.close();
		$chatWindow.empty();
		$('.chat-wrapper').hide();
		$('.chat-signin').show();
		$nickName.focus();
	}
 
	$(document).ready(function() {
	     
		$("#panel1").height($("body").height());
		$nickName = $('#nickname');
		$message = $('#message');
		$chatWindow = $('#response');
		$('.chat-wrapper').hide();
		$nickName.focus();
 
		$('#enterRoom').click(function(evt) {
			evt.preventDefault();
			connectToChatserver();
			$('.chat-wrapper h4').text($nickName.val() + "@ " + room);
			$('.chat-signin').hide();
			$('.chat-wrapper').show();
			$message.focus();
		});
		$('#do-chat').submit(function(evt) {
			evt.preventDefault();
			sendMessage()
		});
 
		$('#leave-room').click(function(){
			leaveRoom();
		});
	});
	
