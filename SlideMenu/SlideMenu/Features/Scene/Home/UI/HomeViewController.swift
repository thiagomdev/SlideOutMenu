import UIKit

final class HomeViewController: UITableViewController {
    private lazy var mainWindow = UIApplication.shared.keyWindow
    private let menuWidth: CGFloat = 250
    
    private lazy var menuViewController: MenuViewController = {
        let menu = MenuViewController()
        menu.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
        return menu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

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
        mainWindow?.addSubview(menuViewController.view)
        addChild(menuViewController)
        view.layoutIfNeeded()
        UIView.animate(
            withDuration: 0.8,
            delay: .zero,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut
        ) {
            self.menuViewController.view.transform = CGAffineTransform(translationX: self.menuWidth, y: 0)
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    private func handleLeftButton() {
        UIView.animate(
            withDuration: 0.8,
            delay: .zero,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut
        ) {
            self.menuViewController.view.transform = .identity
            self.view.layoutIfNeeded()
        }
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
