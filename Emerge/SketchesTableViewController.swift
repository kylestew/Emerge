import UIKit

class SketchesTableViewController: UITableViewController {
    
    let sketches:[String]
    
    required init?(coder aDecoder: NSCoder) {
        sketches = [
            
            "custom_wave_rider",
            "custom_tail_collapse",
            "p5art_bezier_demo",
            
            "basic_rect",
            "structure_recursion",
            
            "simulation_game_of_life",
            "simulate_spirograph",
            
            "math_additive_wave",
            "triangle_strip",
            "triangle_strip_advanced",
            
            "3d_sine_cosine_in_3d",
            // TODO: controls don't work
//            "3d_orbit_control",
            // TODO: texture asset loading
//            "3d_textures",
            
            // TODO: mic input doesn't work
//            "sound_mic_input",
            // TODO: how to stop audio?
//            "sound_oscillator_frequency",
            
            "simulate_flocking",
            "math_noise_wave",
            
            // TODO: acceleration values aren't very responsive
//            "mobile_acceleration_ball_bounce",
            
        ]
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // style navbar for whole app
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // TEMP: TODO: autoroute
//        selectSketch(sketches[1])
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sketches.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = sketches[indexPath.item]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectSketch(sketches[indexPath.item])
    }
    
    func selectSketch(sketch: String) {
        let vc = SketchViewController.createWithSketch(sketch)
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        navigationController?.pushViewController(vc, animated: true)
    }

}
