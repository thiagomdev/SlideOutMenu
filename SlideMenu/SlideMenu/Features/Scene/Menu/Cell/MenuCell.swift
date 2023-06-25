import UIKit

final class MenuCell: UITableViewCell {
    static let identifier: String = MenuCell.self.description()
    
    private lazy var personImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.image = UIImage(systemName: "person.circle")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuCell: ViewConfiguration {
    func buildViewHierarchy() {
        contentView.addSubview(personImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            personImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            personImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ])
    }
    
    func viewConfiguration() {
        backgroundColor = .systemCyan
    }
}
