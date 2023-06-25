import UIKit

final class HomeViewController: UITableViewController {
    // MARK: - Properties
    private let menuWidth: CGFloat = 230
    private var isMenuOpened: Bool = false
    private let velocityOpenThreshold: CGFloat = 500
    
    // MARK: - Components
    private lazy var menuViewController: MenuViewController = {
        let menu = MenuViewController()
        return menu
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupMenuViewController()
        //TODO: - RESOLVE A BUG REGARING BLACK WINDOW SOMETIMES TO performPanGesture()
//        performPanGesture()
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

// MARK: - HomeViewController Private Methods
extension HomeViewController {
    private func setupMenuViewController() {
        menuViewController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(menuViewController.view)
        addChild(menuViewController)
    }
    
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
            //TODO: - RESOLVE A BUG REGARING BLACK WINDOW SOMETIMES
//            self.navigationController?.view.transform = transform
        }
    }
    
    private func performPanGesture() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        view.addGestureRecognizer(gesture)
    }
    
    private func handleEnded(_ panGesture: UIPanGestureRecognizer) {
        setupHandlePanGesture(to: panGesture)
    }
    
    private func setupHandlePanGesture(to gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        if isMenuOpened {
            if  abs(velocity.x) > velocityOpenThreshold {
                handleHideMenu()
                return
            }
            
            if abs(translation.x) < menuWidth / 2 {
                handleOpenMenu()
            } else {
                handleHideMenu()
            }
        } else {
            if velocity.x > velocityOpenThreshold {
                handleOpenMenu()
                return
            }
            
            if translation.x < menuWidth / 2 {
                handleHideMenu()
            } else {
                handleOpenMenu()
            }
        }
    }
    
    private func handleTranslation(from translation: UIPanGestureRecognizer) {
        let translation = translation.translation(in: view)
        var translationX = translation.x
        
        if isMenuOpened { translationX += menuWidth }
        
        translationX = min(menuWidth, translationX)
        translationX = max(0, translationX)
        
        let transform = CGAffineTransform(translationX: translationX, y: 0)
        menuViewController.view.transform = transform
        view.transform = transform
        
        //TODO: RESOLVE A BUG REGARING BLACK WINDOW SOMETIMES
//        navigationController?.view.transform = transform
    }
}

// MARK: - HomeViewController Selector Methods
extension HomeViewController {
    @objc
    private func handleOpenMenu() {
        perfomAnimations(by: .init(translationX: menuWidth, y: 0))
    }
    
    @objc
    private func handleHideMenu() {
        perfomAnimations(by: .identity)
    }
    
    @objc
    private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        if gesture.state ==  .changed {
            handleTranslation(from: gesture)
        } else if gesture.state == .ended {
            handleEnded(gesture)
        }
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
        view.backgroundColor = .systemBackground
        setupNavigationItems(
            rightTitle: "Open",
            leftTitle: "Hide",
            style: .plain,
            rightAction: #selector(handleOpenMenu),
            leftAction: #selector(handleHideMenu)
        )
    }
}
