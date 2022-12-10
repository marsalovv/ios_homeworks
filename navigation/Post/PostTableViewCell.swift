
import UIKit
import StorageService

    class PostTableViewCell: UITableViewCell {
    
    //MARK: - Data
    
    private lazy var authorLabel: UILabel = {
        let author = UILabel()
        author.font = .systemFont(ofSize: 20, weight: .bold)
        author.textColor = .black
        author.numberOfLines = 2
        author.isAccessibilityElement = true
        author.accessibilityTraits = .header
        author.translatesAutoresizingMaskIntoConstraints = false
        
        return author
    }()
    
    private lazy var castomImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .clear
        image.isAccessibilityElement = true
        
        return image
    }()
    
    private lazy var descriptionLabel : UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.isAccessibilityElement = true
        description.font = .systemFont(ofSize: 14, weight: .regular)
        description.textColor = .systemGray
        description.numberOfLines = 0
        
        return description
    }()
    
    private lazy var likesLabel : UILabel = {
        let likes = UILabel()
        likes.translatesAutoresizingMaskIntoConstraints = false
        likes.isAccessibilityElement = true
        likes.font = .systemFont(ofSize: 16, weight: .regular)
        likes.textColor = .black
        
        return likes
    }()
    
    private lazy var viewsLabel : UILabel = {
        let views = UILabel()
        views.translatesAutoresizingMaskIntoConstraints = false
        views.font = .systemFont(ofSize: 16, weight: .regular)
        views.textColor = .black
        views.isAccessibilityElement = true
        
        return views
    }()
    
        //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    
    func setupCell (_ post: Post) {
        self.backgroundColor = .clear
        authorLabel.text = post.author
        castomImageView.image = UIImage(named: post.image)
        descriptionLabel.text = post.description
        likesLabel.text = "Лайки: \(String(post.likes))"
        viewsLabel.text = "Просмотры: \(String(post.views))"
    }
    
    private func setupContentView() {
        [authorLabel, descriptionLabel, castomImageView, likesLabel, viewsLabel].forEach {contentView.addSubview($0)}
        contentView.backgroundColor = .clear
    }
                      
    private func setupConstraints () {
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            castomImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            castomImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            castomImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            castomImageView.heightAnchor.constraint(equalTo: castomImageView.widthAnchor),
            castomImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: castomImageView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            likesLabel.widthAnchor.constraint(equalTo: viewsLabel.widthAnchor),
            
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
            
    }
                      
}
                    
