import UIKit
//import ReactiveCocoa

struct Slider: Binding {
    let displayCell:InputDisplayCell.Type = SliderCell.self
    
    var key:String
    var title = "slider"
    var minValue:Double
    var maxValue:Double
    
    var value = MutableProperty<Double>(0.0)
    func setValue(value: AnyObject) {
        // TODO: conditionally unwrap value
        print(value)
    }
    
    
    // func postValue() { controller.postValue }
}

class SliderCell: UICollectionViewCell, InputDisplayCell, UIGestureRecognizerDelegate {
    static let identifier = "slider"
    static let cellWidth = CGFloat(80.0)

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var trackView: UIView!
    @IBOutlet weak var thumbView: UIView!
    @IBOutlet weak var thumbHeightReversedConstraint: NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: Selector("panGestureRecognized:"))
        panGesture.delegate = self
        addGestureRecognizer(panGesture)
    }
    
    // if swiping horizontally, let gesture fall to CollectionView
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let velocity = panRecognizer.velocityInView(self)
            return abs(velocity.y) >= abs(velocity.x)
        }
        return false
    }
    
    var slider:Slider? {
        didSet {
//                if let slide = self.slider {
//            slider?.wireTo.producer.startWithNext({ newValue -> () in
//                    let percent = CGFloat((newValue - slide.minValue) / (slide.maxValue - slide.minValue))
//                    let tH = self.trackView.frame.size.height - self.thumbView.frame.size.height
//                    self.thumbHeightReversedConstraint.constant = -tH * percent // is reversed
//                }
//            })
        }
    }
    
    // unwrap
    var binding:Binding? {
        didSet {
            if let bound = binding {
                self.slider = bound as? Slider
                self.titleLabel.text = bound.title.uppercaseString
            }
        }
    }
    
    func panGestureRecognized(gesture: UIPanGestureRecognizer) {
        let point = gesture.translationInView(self)
        gesture.setTranslation(CGPointZero, inView: self) // zero out
        
        // determine unit percentage of movement
        let tH = self.trackView.frame.size.height - self.thumbView.frame.size.height
        let percentage = -point.y / tH
        
        // set value change by percentage
        if let slide = slider {
            let delta = (slide.maxValue - slide.minValue) * Double(percentage)
            var newVal = slide.wireTo.value + delta
            newVal = min(newVal, slide.maxValue)
            newVal = max(newVal, slide.minValue)
            slide.value.value = newVal
        }
    }
    
}