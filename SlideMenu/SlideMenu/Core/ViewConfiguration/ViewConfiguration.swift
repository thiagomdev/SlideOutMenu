import Foundation

protocol ViewConfiguration {
    func buildViewHierarchy()
    func setupConstraints()
    func viewConfiguration()
}

extension ViewConfiguration {
    func setup() {
        buildViewHierarchy()
        setupConstraints()
        viewConfiguration()
    }
    
    func viewConfiguration() {  }
}
