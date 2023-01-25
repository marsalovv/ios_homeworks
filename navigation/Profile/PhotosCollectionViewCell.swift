

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    let photo: UIImageView = {
        let photo = UIImageView()
        photo.isAccessibilityElement = true
        photo.translatesAutoresizingMaskIntoConstraints = false
        
        return photo
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
     required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        contentView.addSubview(photo)
        
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: contentView.topAnchor),
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }
}
