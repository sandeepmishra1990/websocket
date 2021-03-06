<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<style>
.panel-info {
    height: ;
}
</style>

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<script>
	var wsocket;
	var serviceLocation = "wss://websocket1990.herokuapp.com/chatwithme/";
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
</script>
</head>
 
<body>
 
	<div class="container chat-signin">
		<form class="form-signin">
			<h2 class="form-signin-heading">Chat sign in</h2>
			<label for="nickname">Name:</label> <input type="text"
				class="input-block-level" placeholder="Nickname" id="nickname">
			<div class="btn-group">
				<label for="chatroom">Chatroom</label> <select size="1"
					id="chatroom">
					<option>Neutral room</option>
					<option>Fight room</option>
					<option>Love room</option>
					
				</select>
			</div>
			<button class="btn btn-large btn-primary" type="submit"
				id="enterRoom">Go</button>
		</form>
	</div>
	<!-- /container -->
 
	<div class="container-fluid chat-wrapper">
		<form id="do-chat">
			<h4 class="alert alert-success"></h4>
			<div class="panel panel-info panel1" >
      <div class="panel-heading">Chat Box</div>
      <div class="panel-body">
    
			<table id="response" class="table " ></table>
			</div>
			</div>
			<fieldset>
					<div class="controls">
					<div class="input-group">
					 <span class="input-group-addon">Text</span>
					<input type="text" class="form-control" placeholder="Your message..." id="message" autocomplete="off" style="height:50px"/>
					</div>
					<input type="submit" class="btn btn-large btn-block btn-primary"
						value="Send message" />
					<button class="btn btn-large btn-block" type="button" id="leave-room">Exit
					</button>
				</div>
			</fieldset>
		</form>
	</div>
</body>
</html>
