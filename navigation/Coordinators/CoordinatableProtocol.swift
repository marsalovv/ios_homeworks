import UIKit

protocol Coordinatable {
    var parentCoordinator: Coordinatable? { get set }
    var children: [Coordinatable] { get set }
    
    func start() -> UIViewController
}
