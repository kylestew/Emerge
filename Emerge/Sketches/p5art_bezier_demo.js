// http://codepen.io/p5art/pen/MaaNLR

var a, b, c, d;
var sz = 15,
theta, theta2;
var frms = 600,
dir = 1,
pos = 0,
fc = 1,
fc2, edge = 50;
var points = []; // frms
var v = []; // 6

function setup() {
    a = createVector(50, 500);
    b = createVector(100, 25);
    c = createVector(350, 50);
    d = createVector(500, 350);
    initStuff();
}

function draw() {
    background(20);
    textAlign(RIGHT);
    text("click mouse to generate new anchor points",width-20,30)
    strokeWeight(3);
    var l = map(sin(theta - PI / 2), -1, 1, 0, 1);
    
    v[0] = p5.Vector.lerp(a, b, l);
    v[1] = p5.Vector.lerp(b, c, l);
    v[2] = p5.Vector.lerp(c, d, l);
    v[3] = p5.Vector.lerp(v[0], v[1], l);
    v[4] = p5.Vector.lerp(v[1], v[2], l);
    v[5] = p5.Vector.lerp(v[3], v[4], l);
    
    stroke('#577287');
    drawLine(a, b);
    drawLine(b, c);
    drawLine(c, d);
    stroke('#00bd3a');
    drawLine(v[0], v[1]);
    drawLine(v[1], v[2]);
    stroke('#ffaf18');
    drawLine(v[3], v[4]);
    
    stroke('#577287');
    fill(255);
    drawEllipse(a);
    drawEllipse(b);
    drawEllipse(c);
    drawEllipse(d);
    
    stroke(255);
    fill('#577287');
    for (var i = 0; i < 3; i++) drawEllipse(v[i]);
    
    fill('#00bd3a');
    for (var i = 3; i < 5; i++) drawEllipse(v[i]);
    
    fill('#ffaf18');
    drawEllipse(v[5]);
    
    points[pos] = v[5].copy();
    
    for (var i = 0; i <= pos; i++) {
        fill('#ff1935');
        if (i == pos) {
            stroke(255);
        } else {
            noStroke();
        }
        ellipse(points[i].x, points[i].y, sz, sz);
    }
    
    if (dir > 0) {
        pos++;
    } else {
        pos--;
    }
    
    if (fc%2000===0) initStuff();
    
    if ((fc) % ((frms / 2)) === 0) {
        dir *= -1;
    }
    fc++;
    theta += TWO_PI / frms;
    theta2 += TWO_PI / (frms / 2);
}

function initStuff() {
    background(20);
    theta = 0;
    theta2 = 0;
    pos = 0;
    fc = 1;
    dir = 1;
    v = [];
    points = [];
    a = createVector(random(edge,width-edge), random(edge,height-edge));
    b = createVector(random(edge,width-edge), random(edge,height-edge));
    c = createVector(random(edge,width-edge), random(edge,height-edge));
    d = createVector(random(edge,width-edge), random(edge,height-edge));
}

function drawLine(p1, p2) {
    line(p1.x, p1.y, p2.x, p2.y);
}

function drawEllipse(p) {
    ellipse(p.x, p.y, sz, sz);
}

function mouseReleased() {
    initStuff();
}
