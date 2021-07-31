//
//  LargrImageViewImp.swift
//  XIAGTest
//
//  Created by Денис Солодовник on 31.07.2021.
//

import UIKit

final class LargePhotoViewImp: UIView, LargePhotView {
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        configurate()
    }

    // MARK: - Internal

    func displayLoadingState() {
        loadingStateView.display(uiView: self)
    }

    func displayErrorState(_ error: String) {
        errorStateView.display(error: error, uiView: self)
    }

    func hideAllStates() {
        loadingStateView.hide()
        errorStateView.hide()
    }

    func display(photo: UIImage?) {
        largePhotoView.image = photo
    }

    // MARK: - Private

    private lazy var loadingStateView: LoadingStateView = {
        LoadingStateView()
    }()

    private lazy var errorStateView: ErrorStateView = {
        ErrorStateView()
    }()

    private lazy var largePhotoView: UIImageView = {
        let photo = UIImageView(frame: .zero)
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.contentMode = .scaleAspectFit
        return photo
    }()

    private func configurate() {
        backgroundColor = .white
        largePhotoView.backgroundColor = .clear

        addSubview(largePhotoView)

        NSLayoutConstraint.activate([
            largePhotoView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            largePhotoView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            largePhotoView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            largePhotoView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
