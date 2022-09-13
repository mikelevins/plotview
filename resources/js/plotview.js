var UpdateParameters = {};
var PlotviewSocket = new WebSocket("ws://127.0.0.1:40404/plotview");

function getCanvas (){
    let canvas = document.getElementById('plotview-canvas');
    return canvas;
}

function clearCanvas(){
    let canvas = getCanvas();
    let ctx = canvas.getContext("2d");
    ctx.clearRect(0,0,canvas.width,canvas.height);
}

function drawStroke(){
    let canvas = getCanvas();
    let ctx = canvas.getContext("2d");
    ctx.moveTo(0,0);
    ctx.lineTo(100,100);
    ctx.stroke();
}

function consoleLogMessage(messageData) {
    console.log('Message received: ');
    console.log(messageData);
}

function handleMessage(messageData) {
    let msg = messageData['message'];
    if (msg == 'clear-canvas') {
        clearCanvas();
    } else if (msg == "draw-stroke") {
        drawStroke();
    } else {
    }
}


PlotviewSocket.onmessage = function (event) {
    var messageData = JSON.parse(event.data);
    handleMessage(messageData);
}
