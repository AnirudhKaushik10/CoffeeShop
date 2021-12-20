import UIKit

class CardCell: UITableViewCell {
    
    var titleLabel = UILabel()
    var orderLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        addSubview(orderLabel)
        loadSubViews()
        addConstraints()
    }
    
    func loadSubViews() {
        orderLabel.numberOfLines = 0
        orderLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        orderLabel.adjustsFontSizeToFitWidth = true
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        orderLabel.font = UIFont.systemFont(ofSize: 23.0)
        orderLabel.backgroundColor = UIColor.lightGray
        titleLabel.backgroundColor = UIColor.lightGray
    }
    
    func addConstraints() {
        orderLabel.translatesAutoresizingMaskIntoConstraints = false
        orderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 80).isActive = true
        orderLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -35).isActive = true
        orderLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: orderLabel.topAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func set(title:String, order:Array<String>) {
        titleLabel.text = title
        
        for item in order {
            orderLabel.text = (orderLabel.text ?? "") + "\n" + item
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
