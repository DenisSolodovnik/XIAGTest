//
//  LargrImageView.swift
//  XIAGTest
//
//  Created by Денис Солодовник on 31.07.2021.
//

import UIKit

class NavigationImp: UINavigationController, Navigation {
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "GalleryVC") as? GalleryVC {
            vc.setDI(networkProvider: GalleryNetworkImp(), router: self)
            pushViewController(vc, animated: true)
        }
    }

    // MARK: - Internal

    func showLargePhoto(
        photo url: String?,
        photo image: UIImage?,
        completion: ((UIImage?) -> Void)?
    ) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let largeImageScreen = storyboard
            .instantiateViewController(withIdentifier: "LargrImageVC") as? LargePhotoVC {
            self.largeImageScreen = largeImageScreen
            largeImageScreen.setDI(networkProvider: GalleryNetworkImp(), router: self)
            largeImageScreen.setData(photo: url, photo: image, completion: completion)
            largeImageScreen.modalPresentationStyle = .formSheet
            present(largeImageScreen, animated: true)
        }
    }

    func hideLargePhoto() {
        largeImageScreen?.dismiss(animated: true)
    }

    // MARK: - Private

    private var largeImageScreen: LargePhotoVC?
}
