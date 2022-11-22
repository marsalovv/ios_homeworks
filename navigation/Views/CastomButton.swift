
import UIKit

class CastomButton: UIButton {
    
    var action: (() -> Void)?
    
    init(title: String, TitleColor: UIColor = .black) {
        super.init(frame: .zero)
         setTitle(title, for: .normal)
        setTitleColor(TitleColor, for: .normal)
        addTarget(self, action: #selector(tap), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tap() {
        action?()
    }
    
}

