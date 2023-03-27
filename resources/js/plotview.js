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
    ctx.lineTo(canvas.width,canvas.height);
    ctx.stroke();
}

function testVega(){
    location.replace('http://localhost:20202/vegatest');
}

function consoleLogMessage(messageData) {
    console.log('Message received: ');
    console.log(messageData);
}

var LastMessageValue = null;

function renderSpec(spec) {
    view = new vega.View(vega.parse(spec),{
        renderer: 'canvas',
        container: '#renderdiv',
        hover: false
    });
}

var testSpec = {
    $schema: 'https://vega.github.io/schema/vega-lite/v5.json',
    data: {
        values: [
            {a: 'C', b: 2},
            {a: 'C', b: 7},
            {a: 'C', b: 4},
            {a: 'D', b: 1},
            {a: 'D', b: 2},
            {a: 'D', b: 6},
            {a: 'E', b: 8},
            {a: 'E', b: 4},
            {a: 'E', b: 7}
        ]
    },
    mark: 'bar',
    encoding: {
        y: {field: 'a', type: 'nominal'},
        x: {
            aggregate: 'average',
            field: 'b',
            type: 'quantitative',
            axis: {
                title: 'Average of b'
            }
        }
    }
};

function handleMessage(messageData) {
    LastMessageValue = messageData;
    let msg = messageData['message'];
    if (msg == 'clear-canvas') {
        clearCanvas();
    } else if (msg == "draw-stroke") {
        drawStroke();
    } else if (msg == "vega-test") {
        testVega();
    } else {
        console.log('unrecognized message: '+msg);
        console.log(messageData);
    }
}


PlotviewSocket.onmessage = function (event) {
    var messageData = JSON.parse(event.data);
    handleMessage(messageData);
}
