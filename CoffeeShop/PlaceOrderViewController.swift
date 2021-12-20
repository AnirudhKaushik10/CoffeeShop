import UIKit

protocol submitOrderDelegate {
    func submitOrder(date: String, order: Array<String>)
}


class PlaceOrderViewController: UIViewController {
    
    @IBOutlet var holder: UIView!
    let currentOrderLabel = UITextView()
    let submitButton = UIButton.init(type: .roundedRect)
    let addItemButton = UIButton.init(type: .roundedRect)
    let label = UILabel()
    var currentOrderArray = [String]()
    var orderDelegate: submitOrderDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSubViews()
        setAttributesForSubViews()
        addConstraints()
    }
    
    func loadSubViews() {
        let date = getDateTime()
        label.text = "Order For\n" + date
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white
        label.numberOfLines = 0
        //label.frame = CGRect(x: 110, y: 50, width: 100, height: 52)
        self.view.addSubview(label)
        
        //addItemButton.frame = CGRect(x: 60, y: 350, width: 200, height: 52)
        addItemButton.setTitle("Add item", for: .normal)
        addItemButton.backgroundColor = UIColor.white
        addItemButton.setTitleColor(UIColor.blue, for: .normal)
        addItemButton.addTarget(self, action: #selector(addItem(_ :)), for: .touchUpInside)
        self.view.addSubview(addItemButton)
        
        //submitButton.frame = CGRect(x: 60, y: 400, width: 200, height: 52)
        submitButton.setTitle("Submit Order", for: .normal)
        let bgColor = UIColor.blue.withAlphaComponent(0.7)
        submitButton.layer.cornerRadius = 15
        submitButton.backgroundColor = bgColor
        submitButton.setTitleColor(UIColor.white, for: .normal)
        submitButton.addTarget(self, action: #selector(submitOrder(_ :)), for: .touchUpInside)
        self.view.addSubview(submitButton)
    }
    
    func setAttributesForSubViews() {
        currentOrderLabel.textAlignment = .center
        currentOrderLabel.textColor = .black
        currentOrderLabel.backgroundColor = .white
        self.view.addSubview(currentOrderLabel)
        
        submitButton.titleLabel?.font = submitButton.titleLabel?.font.withSize(23)
        addItemButton.titleLabel?.font = addItemButton.titleLabel?.font.withSize(23)
        currentOrderLabel.font = UIFont.systemFont(ofSize: 23.0)
        
        label.adjustsFontSizeToFitWidth = true
        submitButton.titleLabel?.adjustsFontSizeToFitWidth = true
        addItemButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        currentOrderLabel.isEditable = false
//        currentOrderLabel.backgroundColor = UIColor.lightGray
        currentOrderLabel.isSelectable = false
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
    }
    
    func addConstraints() {
        var constraints = [NSLayoutConstraint]()

        submitButton.translatesAutoresizingMaskIntoConstraints = false
        addItemButton.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        currentOrderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let screenSize: CGRect = UIScreen.main.bounds
        let height = screenSize.height
        
        constraints.append(label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: height * 0.08))
        constraints.append(label.heightAnchor.constraint(equalToConstant:50))
        constraints.append(label.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor,multiplier: 0.7))
        constraints.append(label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        
        constraints.append(currentOrderLabel.topAnchor.constraint(equalTo: label.safeAreaLayoutGuide.bottomAnchor,constant:height/20))
        constraints.append(currentOrderLabel.heightAnchor.constraint(equalToConstant: height * 0.4))
        constraints.append(currentOrderLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor,multiplier: 0.7))
        constraints.append(currentOrderLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
//        constraints.append(currentOrderLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor))
        
        constraints.append(addItemButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: height * 0.65))
        constraints.append(addItemButton.heightAnchor.constraint(equalToConstant:50))
        constraints.append(addItemButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor,multiplier: 0.3))
        constraints.append(addItemButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        
        constraints.append(submitButton.topAnchor.constraint(equalTo: addItemButton.topAnchor,constant: 60))
        constraints.append(submitButton.heightAnchor.constraint(equalToConstant:50))
        constraints.append(submitButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor,multiplier: 0.7))
        constraints.append(submitButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))

        NSLayoutConstraint.activate(constraints)
    }
    
    func getDateTime() -> String {
        let timestamp = NSDate().timeIntervalSince1970
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
         
        let myTimeInterval = TimeInterval(timestamp)
        let date = Date(timeIntervalSince1970: TimeInterval(myTimeInterval))
         
        // US English Locale (en_US)
        dateFormatter.locale = Locale(identifier: "en_US")
//        print(dateFormatter.string(from: date))
        return dateFormatter.string(from: date)
    }
    
    @objc func addItem(_:UIButton) {
        print("Add Item!")
        guard let menuvc = storyboard?.instantiateViewController(withIdentifier: "menu") as? AddItemViewController else {
            return
        }
        menuvc.selectItemDelegate = self
        present(menuvc,animated: true)
    }
    
    @objc func submitOrder(_:UIButton) {
        orderDelegate.submitOrder(date: "Order For " + getDateTime(),order: currentOrderArray)
        currentOrderArray.removeAll()
        dismiss(animated: true, completion: nil)
    }
    
    func scrollTextViewToBottom(textView: UITextView) {
        if textView.text.count > 0 {
            let location = textView.text.count - 1
            let bottom = NSMakeRange(location, 1)
            textView.scrollRangeToVisible(bottom)
        }
    }
}


extension PlaceOrderViewController: addItemDelegate {
    func addItem(item: String) {
        currentOrderArray.append(item)
        currentOrderLabel.text = (currentOrderLabel.text ?? "") + "\n" + item
        scrollTextViewToBottom(textView: currentOrderLabel)
//        print(currentOrderArray)
    }
}
