var UpdateParameters = {};
var PlotviewSocket = new WebSocket("ws://127.0.0.1:40404/plotview");

function handleMessage(messageData) {
    console.log('handleMessage: ');
    console.log(messageData);
}

PlotviewSocket.onmessage = function (event) {
    var messageData = JSON.parse(event.data);
    handleMessage(messageData);
}
