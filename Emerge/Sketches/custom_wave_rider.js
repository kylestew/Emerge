
function setup() {
    // pass initial prop values to iOS
    registerProp({
                 type: "slider",
                 key: "scale",
                 title: "Scale",
                 value: 0.25,
                 minValue: 0,
                 maxValue: 1
                 });
    
//        gui.addItem(VECGUISlider(owner: self, keyPath: "amplitude", title: "amplitude", min: 0.0, max: 1.0))
//        gui.addItem(VECGUISlider(owner: self, keyPath: "period", title: "period", min: 0.0, max: 24.0))
//        gui.addItem(VECGUISlider(owner: self, keyPath: "offset", title: "offset", min: 0.06, max: 2.0))
//        gui.addItem(VECGUISlider(owner: self, keyPath: "weight", title: "weight", min: 0.1, max: 20.0))
}

function draw() {
    background(127);
    
    noStroke();
    
    rect(0, 0, 0.5*width, 0.5*height);
}