//
//  LargrImageVC.swift
//  XIAGTest
//
//  Created by Денис Солодовник on 31.07.2021.
//

import UIKit

final class LargePhotoVC: UIViewController {
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        if largePhoto == nil {
            loadPhoto()
        } else {
            rootView?.display(photo: largePhoto)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        preferredContentSize = UIScreen.main.bounds.size
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        self.completion?(largePhoto)
    }

    // MARK: - Internal

    func setData(photo url: String?, photo image: UIImage?, completion: ((UIImage?) -> Void)?) {
        largePhoto = image
        largePhotoURL = url
        self.completion = completion
    }

    func setDI(networkProvider: GalleryNetwork, router: Navigation) {
        self.networkProvider = networkProvider
        self.router = router
    }

    // MARK: - Private

    private var rootView: LargePhotView? {
        view as? LargePhotView
    }

    private func loadPhoto() {
        guard let url = largePhotoURL else {
            rootView?.displayErrorState("Can`t find image URL!")
            return
        }

        networkProvider?.photo(urlString: url) { [weak self] photo, error in
            DispatchQueue.main.async { [weak self] in
                guard error.isEmpty, let largePhoto = photo else {
                    self?.rootView?.displayErrorState(error.isEmpty ? "Something went wrong!" : error)
                    return
                }

                self?.largePhoto = largePhoto
                self?.rootView?.hideAllStates()
                self?.rootView?.display(photo: largePhoto)
            }
        }
    }

    private var networkProvider: GalleryNetwork?
    private var router: Navigation?

    private var largePhoto: UIImage?
    private var largePhotoURL: String?

    private var completion: ((UIImage?) -> Void)?
}
