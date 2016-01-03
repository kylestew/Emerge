

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
    createCanvas(640, 640);
    
    // pass initial prop values to iOS
    registerProp({
                 type: "slider",
                 key: "scale",
                 title: "Scale",
                 value: 0.25,
                 minValue: 0,
                 maxValue: 1
    });
}

function draw() {
    background(127);
    noStroke();
    
    rect(0, 0, props.scale*width, props.scale*height);
}
