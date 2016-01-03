import UIKit

protocol Binding {
    var displayCell:InputDisplayCell.Type { get }
    var title:String { get set }
    
    func setValue(value: AnyObject)

}


//protocol Input {
//}

protocol InputDisplayCell {
    static var identifier:String { get }
    static var cellWidth:CGFloat { get }
    var binding:Binding? { get set }
}

protocol InputExtendedUI {
    weak var parentViewController:UIViewController? { get set }
}