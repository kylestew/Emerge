function setup() {
    createCanvas(100, 100);
    
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
