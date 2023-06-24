import UIKit

final class HomeViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "identifier")
        cell.selectionStyle = .none
        cell.textLabel?.text = "Row: \(indexPath.row)"
        return cell
    }
}

extension HomeViewController {
    private func makeNavigationButtons(
        rightTitle: String,
        leftTitle: String,
        style: UIBarButtonItem.Style,
        rightAction: Selector,
        leftAction: Selector
    ) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: rightTitle,
            style: style,
            target: self,
            action: rightAction
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: leftTitle,
            style: style,
            target: self,
            action: leftAction
        )
    }
    
    @objc
    private func handleRightButton() {
        print("Tapping handleRightButton...")
    }
    
    @objc
    private func handleLeftButton() {
        print("Tapping handleLeftButton...")
    }
}

extension HomeViewController: ViewConfiguration {
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func viewConfiguration() {
        navigationItem.title = "Home"
        view.backgroundColor = .white
        makeNavigationButtons(
            rightTitle: "Open",
            leftTitle: "Hide",
            style: .plain,
            rightAction: #selector(handleRightButton),
            leftAction: #selector(handleLeftButton)
        )
    }
}
