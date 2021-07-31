//
// XIAGTest
//
//

import UIKit

final class LoadingStateView: UIView {
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

    func display(uiView: UIView) {
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        activityIndicator.startAnimating()

        uiView.addSubview(self)
    }

    func hide() {
        activityIndicator.stopAnimating()
        removeFromSuperview()
    }

    // MARK: - Private

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .init(named: "AccentColor")
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()

    private func configurate() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(activityIndicator)
    }
}
