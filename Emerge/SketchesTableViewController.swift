import UIKit

class SketchesTableViewController: UITableViewController {
    
    let sketches:[String]
    
    required init?(coder aDecoder: NSCoder) {
        sketches = [
            "basic_rect",
            "structure_recursion",
            "simulation_game_of_life",
            "math_additive_wave",
            "triangle_strip",
            
            "3d_sine_cosine_in_3d",
            "3d_orbit_control",
//            "3d_textures",
            
//            "sound_mic_input",
            "sound_oscillator_frequency",
            
        ]
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // TEMP: TODO: autoroute
//        selectSketch(sketches[0])
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
