import UIKit
import p5native

class SketchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, p5PropsDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var p5Controller:p5ViewController?
    
    var sketch:String?
    var bindings:[String:Binding] = [:]
    var inputs:[Binding] = []
    
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
                    controller.propsDelegate = self
                    controller.loadp5Script(jsCode)
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
    
    // MARK: Prop Bindings
    func p5PropBound(binding: NSDictionary) {
        // parse binding dictionary into bound Binding objects
        if let type = binding["type"] as? String {
            
            switch type {
            case "slider":
                if let key = binding["key"] as? String, value = binding["value"] as? Double, title = binding["title"] as? String {
                    let bound = Slider(key: key, value: value, title: title)
                    bindings[key] = bound
                    inputs.append(bound)
                }
            default: ()
            }
            
        }
        collectionView.reloadData()
    }
    
    func p5PropUpdated(key: String, value: AnyObject) {
        bindings[key]?.setValue(value)
    }
    
    // MARK: CollectionView DataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inputs.count
    }

//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let displayCell = inputs[indexPath.item].displayCell
//        return CGSizeMake(displayCell.cellWidth, self.collectionView.bounds.size.height)
//    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let input = inputs[indexPath.item]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(input.displayCell.identifier, forIndexPath: indexPath)
        // give cell persistent copy of input
        if var displayCell = cell as? InputDisplayCell {
            displayCell.binding = input
//            if var extendedUI = displayCell as? InputExtendedUI {
//                extendedUI.parentViewController = self
//            }
        }
        return cell
    }
    
}

