

import UIKit

class PhotosViewController: UIViewController {
    
    //MARK: - Data
    
    private lazy var collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        return collection
    }()
    
    //Mark: - Life Cyckle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionview)
        view.backgroundColor = .white
        
        navigationItem.title = "Photo gallery"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        
        setupConstrayns()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - Private
    
    private func setupConstrayns() {
        let safeArie = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionview.topAnchor.constraint(equalTo: safeArie.topAnchor),
            collectionview.leadingAnchor.constraint(equalTo: safeArie.leadingAnchor),
            collectionview.trailingAnchor.constraint(equalTo: safeArie.trailingAnchor),
            collectionview.bottomAnchor.constraint(equalTo: safeArie.bottomAnchor)
        ])
    }
    
}

//MARK: - Extension

extension PhotosViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        cell.photo.image = UIImage(named: "\(indexPath.item)")
        cell.photo.accessibilityLabel = "Изображение номер \(indexPath.row + 1)"
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    private var inset: CGFloat {return 8}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.bounds.width - inset * 4) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}
