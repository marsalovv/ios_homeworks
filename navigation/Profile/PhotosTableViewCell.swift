
import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    //MARK: - Data
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Photo"
        label.textColor = .Pallete.black
        label.backgroundColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.isAccessibilityElement = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var arrow: UIImageView = {
        let arrow = UIImageView()
        arrow.image = UIImage(systemName: "arrow.right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        arrow.isAccessibilityElement = true
        arrow.translatesAutoresizingMaskIntoConstraints = false
        
        return arrow
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.clipsToBounds = true
        
        for i in 0...3 {
            let image = UIImageView()
            image.image = UIImage(named: "\(i)")
            image.isAccessibilityElement = true
            image.clipsToBounds = true
            image.layer.cornerRadius = 8
            image.translatesAutoresizingMaskIntoConstraints = false
            
            stackView.addArrangedSubview(image)
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    //MARK: - Setup
    
    func setupCell() {
        self.backgroundColor = .clear
        contentView.addSubview(label)
        contentView.addSubview(stackView)
        contentView.addSubview(arrow)
        
        setupConstrayns()
    }
    
    private func setupConstrayns() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            label.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -12),
            
            arrow.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            arrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrow.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -12),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            //stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            stackView.widthAnchor.constraint(equalToConstant: contentView.bounds.width - 24),
            stackView.heightAnchor.constraint(equalToConstant: (contentView.bounds.width - 48) / 4)
        ])
    }
    
}
