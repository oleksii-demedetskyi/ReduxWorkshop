import UIKit

class AllCardsViewController: UITableViewController {
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "card-details") else {
            fatalError("Cannot get card cell from \(tableView)")
        }
        
        cell.textLabel?.text = "Some card title"
        
        return cell
    }
}
