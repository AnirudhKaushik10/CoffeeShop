import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MenuCollectionViewCell"
    var imageview = UIImageView()
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageview)
        contentView.addSubview(label)
        imageview.contentMode = .scaleToFill
        imageview.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageview.frame = CGRect(x: contentView.bounds.minX + 15, y: contentView.bounds.minY + 10, width: contentView.bounds.width-35, height: contentView.bounds.height-45)
        imageview.layer.cornerRadius = imageview.frame.width/2
        imageview.layer.masksToBounds = false
        imageview.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 41).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
