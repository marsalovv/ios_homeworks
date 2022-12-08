
import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    //MARK: - Data
    
    private var images: [UIImage] = []
    
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
        
        var processedImages = [UIImage]()
        images = makeImages()
        let imageProcessor = ImageProcessor()
        
        let start = CFAbsoluteTimeGetCurrent()
        imageProcessor.processImagesOnThread(
            sourceImages: images,
            filter: .colorInvert,
            qos: .utility
        ) { cgImages in
            for cgImage in cgImages {
                processedImages.append(UIImage(cgImage: cgImage!))
            }
            let stop = CFAbsoluteTimeGetCurrent()
            
            print(start.distance(to: stop))
            
            DispatchQueue.main.async { [self] in
                images = processedImages
                collectionview.reloadData()
            }
            
        }
        
        /* userInteractive = 0.227605938911438
         background = 0.51882004737854
         default = 0.34844696521759033
         userInitiated = 0.27252697944641113
         utility = 0.39250898361206055 */
        
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
        //cell.photo.image = UIImage(named: "\(indexPath.item)")
        cell.photo.image = images[indexPath.item]
        if images[indexPath.item].accessibilityLabel?.isEmpty == true {
            cell.photo.accessibilityLabel = "Изображение номер \(indexPath.row + 1)"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
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

extension PhotosViewController {
    
    func makeImages() -> [UIImage]{
        var array = [UIImage]()
        for i in 0...19 {
            
            array.append(UIImage(named: String(i))!)
        }
        
        return array
    }
    
}

