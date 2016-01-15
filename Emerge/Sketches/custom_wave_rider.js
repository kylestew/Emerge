
function setup() {
    // pass initial prop values to iOS
    registerProp({
                 type: PropTypeEnum.SLIDER,
                 key: "amplitude",
                 title: "amplitude",
                 value: 0.5,
                 minValue: 0,
                 maxValue: 1
                 });
    registerProp({
                 type: PropTypeEnum.SLIDER,
                 key: "period",
                 title: "period",
                 value: 1.0,
                 minValue: 0,
                 maxValue: 24.0
                 });
    registerProp({
                 type: PropTypeEnum.SLIDER,
                 key: "offset",
                 title: "offset",
                 value: 0.5,
                 minValue: 0.06,
                 maxValue: 2.0
                 });
    registerProp({
                 type: PropTypeEnum.SLIDER,
                 key: "weight",
                 title: "weight",
                 value: 4.0,
                 minValue: 0.1,
                 maxValue: 20.0
                 });
    registerProp({
                 type: PropTypeEnum.SLIDER,
                 key: "rotate",
                 title: "rotate",
                 value: 0.0,
                 minValue: 0,
                 maxValue: 180
                 });
}

function draw() {
    background(0);
    stroke(255);
    
    var centerX = width/2.0;
    var centerY = height / 2.0;
    var scale = height / 4;
    var start = -3.0 * (width / height); // account for angled view
    var precision = 0.01;
    
    push();
    translate(width/2.0, width/2.0);
    rotate(radians(props.rotate));
    translate(-width/2.0, -width/2.0);
    
    
    noFill();
    strokeWeight(props.weight);
    for (var yOff = start * 2; yOff < abs(start * 2); yOff += props.offset) {
        beginShape();
        for (var x = start; x < abs(start); x += precision) {
            var y = props.amplitude * sin(props.period*x);
            var posX = x * scale + centerX;
            var posY = (-y + yOff) * scale + centerY;
            vertex(posX, posY);
        }
        endShape();
    }
    pop();
}