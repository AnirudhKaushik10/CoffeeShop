import UIKit

class OrderTableView: UITableViewController {
    var orderDate = [String]()
    var orderItems = [Array<String>]()
    
    override func viewDidLoad() {
        self.tableView.estimatedRowHeight = 350
        self.tableView.rowHeight = UITableView.automaticDimension
//        self.tableView.rowHeight = 350
        self.tableView.register(CardCell.self, forCellReuseIdentifier: "CardCell")
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell") as! CardCell
        let order = orderItems[indexPath.row]
        let title = orderDate[indexPath.row]
        cell.set(title: title,order: order)
        cell.backgroundColor = UIColor.lightGray
        cell.isUserInteractionEnabled = false
        return cell
    }
    
}

