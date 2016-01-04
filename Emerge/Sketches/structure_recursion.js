// http://p5js.org/examples/examples/Structure_Recursion.php

function setup() {
    // TODO: figure out how to inject size here
    createCanvas(375, 375);
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