import UIKit

final class HomeViewController: UITableViewController {
    // MARK: - Properties
    private let menuWidth: CGFloat = 256
    
    // MARK: - Components
    private lazy var menuViewController: MenuViewController = {
        let menu = MenuViewController()
        return menu
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupMenuViewController()
    }
}

// MARK: - UITableViewController Protocols
extension HomeViewController {
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

// MARK: - HomeViewController private methods
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
    
    private func setupMenuViewController() {
        menuViewController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(menuViewController.view)
        addChild(menuViewController)
    }

    private func perfomAnimations(by transform: CGAffineTransform) {
        UIView.animate(
            withDuration: 0.9,
            delay: .zero,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut
        ) {
            self.menuViewController.view.transform = transform
            self.view.transform = transform
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - HomeViewController @Selectors
extension HomeViewController {
    @objc
    private func handleRightButton() {
        setupMenuViewController()
        perfomAnimations(by: .init(translationX: menuWidth, y: 0))
    }
    
    @objc
    private func handleLeftButton() {
        perfomAnimations(by: .identity)
    }
}

// MARK: - UI ViewConfiguration
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
