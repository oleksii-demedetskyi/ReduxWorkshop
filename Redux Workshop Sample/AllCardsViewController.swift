import UIKit

class AllCardsViewController: UITableViewController {
    struct Props {
        let cards: [String]
    }
    
    var props: Props = Props(cards: []){
        didSet { tableView.reloadData() }
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return props.cards.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        precondition(props.cards.indices.contains(indexPath.row))
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "card-details") else {
            fatalError("Cannot get card cell from \(tableView)")
        }
        
        cell.textLabel?.text = props.cards[indexPath.row]
        
        return cell
    }
}
