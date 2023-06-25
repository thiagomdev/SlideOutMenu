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
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MenuCell.identifier,
            for: indexPath) as? MenuCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension MenuViewController {
    private func registerCell() {
        tableView.register(MenuCell.self, forCellReuseIdentifier: MenuCell.identifier)
    }
}

extension MenuViewController: ViewConfiguration {
    func buildViewHierarchy() {
    }
    
    func setupConstraints() {
        
    }
    
    func viewConfiguration() {
        registerCell()
        view.backgroundColor = .systemCyan
    }
}
