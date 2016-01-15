// http://www.openprocessing.org/sketch/230959

var speed = 1.8;

function setup() {
    noStroke();
}

function draw() {
    background(20);
    
    push();
    translate(width/2, height/2);

    for (var i = 0.0; i < 360; i += 36) {
        for (var q = 0.0; q < 120; q += 10) {
            var x = sin(radians(i))*100+sin(radians(i-q+frameCount*speed*2.5))*50;
            var y = cos(radians(i))*100+cos(radians(i-q+frameCount*speed*2.5))*50;
            var s = map(q, 0, 120, 10, 0);
            fill(map(q, 0, 140, 255, 0), 0, 255);
            ellipse(x, y, s, s);
        }
        
        // Outside tails
        for (var q = 0.0; q < 140; q += 10) {
            var x = sin(radians(i))*120+sin(radians(i+q-frameCount*speed*2.5))*75;
            var y = cos(radians(i))*120+cos(radians(i+q-frameCount*speed*2.5))*75;
            var s = map(q, 0, 140, 15, 0);
            fill(map(q, 0, 140, 255, 0), 0, 255);
            ellipse(x, y, s, s);
        }
    }

    pop();
}
