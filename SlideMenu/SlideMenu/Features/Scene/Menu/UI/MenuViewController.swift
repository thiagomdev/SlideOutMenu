import UIKit

final class MenuViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension MenuViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "identifier")
        cell.selectionStyle = .none
        cell.backgroundColor = .systemCyan
        cell.textLabel?.text = "Row: \(indexPath.row)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension MenuViewController: ViewConfiguration {
    func buildViewHierarchy() {
    }
    
    func setupConstraints() {
        
    }
    
    func viewConfiguration() {
//        tableView.separatorStyle = .none
        view.backgroundColor = .systemCyan
    }
}
