// http://p5js.org/examples/examples/Form_Triangle_Strip.php

var x;
var y;
var outsideRadius = 150;
var insideRadius = 100;

function setup() {
    createCanvas(375, 375);
    background(204);
    x = width/2;
    y = height/2;
    
    // pass initial prop values to iOS
    registerProp({
                 type: "slider",
                 key: "numPoints",
                 title: "Points",
                 value: 6,
                 minValue: 6,
                 maxValue: 60
    });
}

function touchStarted() {
    setProp("numPoints", map(touchX, 0, width, 6, 60));
    return false;
}
function touchMoved() {
    setProp("numPoints", map(touchX, 0, width, 6, 60));
    return false;
}

function draw() {
    background(204);
    
    var points = int(props.numPoints);
    var angle = 0;
    var angleStep = 180.0/points;
    
    beginShape(TRIANGLE_STRIP);
    for (var i = 0; i <= points; i++) {
        var px = x + cos(radians(angle)) * outsideRadius;
        var py = y + sin(radians(angle)) * outsideRadius;
        angle += angleStep;
        vertex(px, py);
        px = x + cos(radians(angle)) * insideRadius;
        py = y + sin(radians(angle)) * insideRadius;
        vertex(px, py);
        angle += angleStep;
    }
    endShape();
}
