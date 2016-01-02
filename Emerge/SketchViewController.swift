import UIKit
import p5native

class SketchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var p5Controller:p5ViewController?
    
    var sketch:String?
//    var inputs:[Input] = []
    
    class func createWithSketch(sketch: String) -> SketchViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("sketch_view") as! SketchViewController
        vc.sketch = sketch
        return vc
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // no swipe-back gesture please
        self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        
        // load sketch
        self.title = sketch
        if let controller = p5Controller {
            if let filepath = NSBundle.mainBundle().pathForResource(sketch, ofType: "js") {
                do {
                    let jsCode = try! String(contentsOfFile: filepath, encoding: NSUTF8StringEncoding)
                    controller.loadp5Script(jsCode)
                    
//                    performUIWiring(controller)
                    
                    return // success
                }
            }
        }
        
        // error - could not start sketch
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // grab reference to contained VC
        p5Controller = segue.destinationViewController as? p5ViewController
    }
    
    
    
    
    

//    // MARK: Wiring
//    func performWiring(mod: Module) {
//        // expose inputs for UI
//        inputs = mod.mapInputs()
//        
//        // start!
//        canvasView.module = mod
//        mod.touchableSurface = canvasView
//        canvasView.run()
//        collectionView.reloadData()
//    }
//    
//    // MARK: CollectionView DataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
//        return inputs.count
    }

//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let displayCell = inputs[indexPath.item].displayCell
//        return CGSizeMake(displayCell.cellWidth, self.collectionView.bounds.size.height)
//    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let input = inputs[indexPath.item]
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(input.displayCell.identifier, forIndexPath: indexPath)
//        // give cell persistent copy of input
//        if var displayCell = cell as? InputDisplayCell {
//            displayCell.input = input
//            if var extendedUI = displayCell as? InputExtendedUI {
//                extendedUI.parentViewController = self
//            }
//        }
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        return cell
    }
    
}

