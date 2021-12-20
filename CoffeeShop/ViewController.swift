import UIKit

class ViewController: UIViewController {
    
    var dateArray = [String]()
    var orderArray = [Array<String>]()
    
    let orderButton = UIButton.init(type: .roundedRect)
    let orderHistoryButton = UIButton.init(type: .roundedRect)
    let firstLabel = UILabel()
    let secondLabel = UILabel()
    var imageView = UIImageView()
    
    let userDefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let date = userDefaults.value(forKey: "dateArray") as? Array<String> {
            dateArray = date
        }
        
        if let order = userDefaults.value(forKey: "orderArray") as? Array<Array<String>> {
            orderArray = order
        }
        
        
        loadSubViews()
        adjustSize()
        addConstraints()
    }
    
    func loadSubViews() {
        //orderButton.frame = CGRect(x: 60, y: 400, width: 200, height: 52)
        orderButton.setTitle("Place Order", for: .normal)
        let bgColor = UIColor.blue.withAlphaComponent(0.7)
        orderButton.layer.cornerRadius = 15
        orderButton.backgroundColor = bgColor
        orderButton.setTitleColor(UIColor.white, for: .normal)
        orderButton.addTarget(self, action: #selector(placeOrder(_ :)), for: .touchUpInside)
        self.view.addSubview(orderButton)
        
        //orderHistoryButton.frame = CGRect(x: 60, y: 450, width: 200, height: 50)
        orderHistoryButton.setTitle("Order history", for: .normal)
        orderHistoryButton.backgroundColor = UIColor.white
        orderHistoryButton.setTitleColor(UIColor.blue, for: .normal)
        orderHistoryButton.addTarget(self, action: #selector(viewOrderHistory(_:)), for: .touchUpInside)
        self.view.addSubview(orderHistoryButton)
        
        firstLabel.text = "Swift Intro"
        firstLabel.adjustsFontSizeToFitWidth = true
        firstLabel.font = UIFont.boldSystemFont(ofSize: 35.0)
        firstLabel.textAlignment = .center
        firstLabel.textColor = .black
        firstLabel.backgroundColor = .white
        firstLabel.numberOfLines = 0
//        firstLabel.frame = CGRect(x: 70, y: 50, width: 180, height: 52)
        self.view.addSubview(firstLabel)
        
        secondLabel.text = "Coffee Shop"
        secondLabel.adjustsFontSizeToFitWidth = true
        secondLabel.font = UIFont.systemFont(ofSize: 28.0)
        secondLabel.textAlignment = .center
        secondLabel.textColor = .black
        secondLabel.backgroundColor = .white
        secondLabel.numberOfLines = 0
        self.view.addSubview(secondLabel)
        
        imageView.image = UIImage(named: "coffee")
        self.view.addSubview(imageView)
    }
    
    func adjustSize() {
        orderButton.titleLabel?.adjustsFontSizeToFitWidth = true
        orderHistoryButton.titleLabel?.adjustsFontSizeToFitWidth = true
        orderButton.titleLabel?.font = orderButton.titleLabel?.font.withSize(23)
        orderHistoryButton.titleLabel?.font = orderHistoryButton.titleLabel?.font.withSize(23)
    }
    
    // TO DO : Properly Place UI elements according to orientation
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
               return .portrait
           }
    }
    
    //Auto Layout Constraints
    func addConstraints() {
        var constraints = [NSLayoutConstraint]()

        orderButton.translatesAutoresizingMaskIntoConstraints = false
        orderHistoryButton.translatesAutoresizingMaskIntoConstraints = false
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let screenSize: CGRect = UIScreen.main.bounds
        let height = screenSize.height
        
        constraints.append(firstLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: height * 0.08))
        constraints.append(firstLabel.heightAnchor.constraint(equalToConstant:height * 0.1))
        constraints.append(firstLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor,multiplier: 0.7))
        constraints.append(firstLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        
        constraints.append(secondLabel.topAnchor.constraint(equalTo: firstLabel.safeAreaLayoutGuide.bottomAnchor,constant:height/100))
        constraints.append(secondLabel.heightAnchor.constraint(equalToConstant:height * 0.05))
        constraints.append(secondLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor,multiplier: 0.7))
        constraints.append(secondLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        
        constraints.append(imageView.topAnchor.constraint(equalTo: secondLabel.safeAreaLayoutGuide.bottomAnchor,constant:30))
        constraints.append(imageView.heightAnchor.constraint(equalToConstant:height * 0.3))
        constraints.append(imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor))
        constraints.append(imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        imageView.layer.cornerRadius = height * 0.3/2
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        
        constraints.append(orderButton.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: height * 0.1))
        constraints.append(orderButton.heightAnchor.constraint(equalToConstant:50))
        constraints.append(orderButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor,multiplier: 0.7))
        constraints.append(orderButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        
        constraints.append(orderHistoryButton.topAnchor.constraint(equalTo: orderButton.bottomAnchor,constant: 10))
        constraints.append(orderHistoryButton.heightAnchor.constraint(equalToConstant:height * 0.1))
        constraints.append(orderHistoryButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor,multiplier: 0.7))
        constraints.append(orderHistoryButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))

        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func placeOrder(_ : UIButton) {
        print("Place the Order!")
        guard let ordervc = storyboard?.instantiateViewController(withIdentifier: "order") as? PlaceOrderViewController else {
            return
        }
        ordervc.orderDelegate = self
        present(ordervc,animated: true)
    }
    
    @objc func viewOrderHistory(_ : UIButton) {
        print("Order History!")
        guard let historytablevc = storyboard?.instantiateViewController(withIdentifier:"historytable") as? OrderTableView else {
                    return
                }
        for i in 0..<orderArray.count {
            historytablevc.orderDate.append(dateArray[i])
            historytablevc.orderItems.append(orderArray[i])
        }
        present(historytablevc,animated: true)
    }
}

extension ViewController: submitOrderDelegate {
    func submitOrder(date: String, order: Array<String>) {
        
        // Check if not empty order
        if order.count > 0 {
            dateArray.append(date)
            orderArray.append(order)
            userDefaults.set(dateArray, forKey: "dateArray")
            userDefaults.set(orderArray, forKey: "orderArray")
            print(dateArray)
            print(orderArray)
        }
    }
}
