//
// XIAGTest
// 
//

import UIKit

final class ErrorStateView: UIView {
    // MARK: - Lifecycle

    init() {
        super.init(frame: .zero)

        configurate()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        guard let sView = superview else {
            return
        }

        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: sView.leadingAnchor),
            trailingAnchor.constraint(equalTo: sView.trailingAnchor),
            topAnchor.constraint(equalTo: sView.safeAreaLayoutGuide.topAnchor),
            bottomAnchor.constraint(equalTo: sView.bottomAnchor)
        ])

        sView.setNeedsLayout()
    }

    override func removeFromSuperview() {
        removeConstraints(constraints)
        super.removeFromSuperview()
    }

    // MARK: - Internal

    func display(error: String, uiView: UIView) {
        NSLayoutConstraint.activate([
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7)
        ])

        errorLabel.text = error

        uiView.addSubview(self)
    }

    func hide() {
        removeFromSuperview()
    }

    // MARK: - Private

    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private func configurate() {
        backgroundColor = .init(named: "ErrorBackgroundColor")
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(errorLabel)
    }
}
