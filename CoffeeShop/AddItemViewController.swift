import UIKit

protocol addItemDelegate {
    func addItem(item: String)
}

class AddItemViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    var selectItemDelegate: addItemDelegate!
    let itemImages = [UIImage(named: "coffee"),UIImage(named: "water"),UIImage(named: "latte"),UIImage(named: "smoothie"),UIImage(named: "Tea")]
    let itemLabels = ["Coffee", "Water", "Latte", "Smoothie", "Tea"]
    
    private let collectionView = UICollectionView (frame: .zero,collectionViewLayout: UICollectionViewFlowLayout())
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemImages.count
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as! MenuCollectionViewCell
        
        cell.imageview.image = itemImages[indexPath.row]
        cell.label.text = itemLabels[indexPath.row]
        
        cell.label.font = UIFont.systemFont(ofSize: 23.0)
        cell.label.adjustsFontSizeToFitWidth = true
        let bgColor = UIColor.lightGray.withAlphaComponent(0.3)
        cell.backgroundColor = bgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (view.frame.width/2)-20, height: (view.frame.width/2))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 25, left: 15, bottom: 0, right: 15)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("selected row \(indexPath.row)")
        selectItemDelegate.addItem(item: itemLabels[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
}
