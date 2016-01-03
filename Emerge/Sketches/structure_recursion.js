// http://p5js.org/examples/examples/Structure_Recursion.php




// TODO: abstract into library
// USER can register almost anything here - needs key/value
var props = {};
function registerProp(prop) {
    props[prop.key] = prop.value;
    window.webkit.messageHandlers.propRegistration.postMessage(prop);
}
// iOS -> p5.js
function receivePropUpdate(key, value) {
    props[key] = value
}
// p5.js -> iOS
function postPropUpdate(key, value) {
    // TODO: update local copy?
    var msg = {};
    msg[key] = value
    window.webkit.messageHandlers.props.postMessage(msg);
}



function setup() {
    createCanvas(1000, 1000);
    noStroke();
//    noLoop();
    
    registerProp({
                 type: "slider",
                 key: "level",
                 title: "Level",
                 value: 3,
                 minValue: 1,
                 maxValue: 12
                 });
}

function draw() {
    drawCircle(width/2, 280, parseInt(this.props.level));
}

function drawCircle(x, radius, level) {
    var tt = 126 * level/4.0;
    fill(tt);
    ellipse(x, height/2, radius*2, radius*2);
    if(level > 1) {
        level = level - 1;
        drawCircle(x - radius/2, radius/2, level);
        drawCircle(x + radius/2, radius/2, level);
    }
}