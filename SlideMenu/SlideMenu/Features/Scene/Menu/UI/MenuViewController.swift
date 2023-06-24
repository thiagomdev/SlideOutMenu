import UIKit

final class MenuViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension MenuViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "identifier")
        cell.selectionStyle = .none
        cell.textLabel?.text = "Row: \(indexPath.row)"
        return cell
    }
}

extension MenuViewController: ViewConfiguration {
    func buildViewHierarchy() {
    }
    
    func setupConstraints() {
        
    }
    
    func viewConfiguration() {
        view.backgroundColor = .systemCyan
    }
}
