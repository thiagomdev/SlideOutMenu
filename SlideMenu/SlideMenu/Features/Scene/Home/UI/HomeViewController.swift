import UIKit

final class HomeViewController: UITableViewController {
    private lazy var mainWindow = UIApplication.shared.keyWindow
    
    private lazy var menuViewController: MenuViewController = {
        let menu = MenuViewController()
        return menu
    }()
    
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
    private func setupNavigationItems(
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
        mainWindow?.addSubview(menuViewController.view)
        addChild(menuViewController)
        menuViewController.view.frame = CGRect(x: 0, y: 0, width: view.frame.width - 150, height: view.frame.height)
    }
    
    @objc
    private func handleLeftButton() {
        print("Tapping handleLeftButton...")
        menuViewController.view.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
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
        setupNavigationItems(
            rightTitle: "Open",
            leftTitle: "Hide",
            style: .plain,
            rightAction: #selector(handleRightButton),
            leftAction: #selector(handleLeftButton)
        )
    }
}
