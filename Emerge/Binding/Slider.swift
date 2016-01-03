import UIKit
import ReactiveCocoa
import p5native

struct Slider: Binding {
    let displayCell:InputDisplayCell.Type = SliderCell.self
    
    var key:String
    var value:MutableProperty<Double>
    var title = "slider"
    var minValue:Double
    var maxValue:Double
    
    static func create(binding: NSDictionary, controller: p5ViewController) -> Slider? {
        if let key = binding["key"] as? String, value = binding["value"] as? Double, title = binding["title"] as? String, minValue = binding["minValue"] as? Double, maxValue = binding["maxValue"] as? Double {
            
            let bound = Slider(key: key, value: MutableProperty<Double>(value), title: title, minValue: minValue, maxValue: maxValue)
            bound.value.producer.startWithNext { newValue in
                controller.setProp(key, value: newValue)
            }
            
            return bound
        }
        return nil
    }
    
    func setValue(value: AnyObject) {
        if let val = value as? Double {
            self.value.value = val
        }
    }
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
            slider?.value.producer.startWithNext({ newValue -> () in
                if let slide = self.slider {
                    let percent = CGFloat((newValue - slide.minValue) / (slide.maxValue - slide.minValue))
                    let tH = self.trackView.frame.size.height - self.thumbView.frame.size.height
                    self.thumbHeightReversedConstraint.constant = -tH * percent // is reversed
                }
            })
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
            var newVal = slide.value.value + delta
            newVal = min(newVal, slide.maxValue)
            newVal = max(newVal, slide.minValue)
            slide.value.value = newVal
        }
    }
    
}