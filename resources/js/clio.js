var UpdateParameters = {};
var ClioSocket = new WebSocket("ws://127.0.0.1:40404/clio");

function handleMessage(messageData) {
    console.log('handleMessage: ');
    console.log(messageData);
}

ClioSocket.onmessage = function (event) {
    var messageData = JSON.parse(event.data);
    handleMessage(messageData);
}
