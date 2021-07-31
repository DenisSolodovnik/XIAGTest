//
//  LargrImageView.swift
//  XIAGTest
//
//  Created by Денис Солодовник on 31.07.2021.
//

import UIKit

fileprivate struct GalleryFullData {
    let galleryData: GalleryItem
    let galleryLargePhoto: UIImage?
    let gallerySmallPhoto: UIImage?
}

final class GalleryVC: UIViewController {
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Gallery".uppercased()

        rootView?.onCellWillAppear = onCellWillAppear
        rootView?.onCellDidSelect = onCellDidSelect

        loadGallery()
    }

    // MARK: - Internal

    func setDI(networkProvider: GalleryNetwork, router: Navigation) {
        self.networkProvider = networkProvider
        self.router = router
    }

    // MARK: - Private

    private var rootView: GalleryView? {
        view as? GalleryView
    }

    private var networkProvider: GalleryNetwork?
    private var router: Navigation?

    private var galleryFullData: [GalleryFullData] = []
    private var galleryData: [GalleryCellData] = []

    private func loadGallery() {
        rootView?.displayLoadingState()

        networkProvider?.gallery(completion: { [weak self] response, error in
            guard let self = self else {
                return
            }

            DispatchQueue.main.async {
                guard error.isEmpty else {
                    self.rootView?.displayErrorState(error)
                    return
                }

                self.rootView?.hideAllStates()
                self.galleryData = self.makeCellsData(response)
                self.galleryFullData = self.makeGalleryData(response)
                self.rootView?.display(data: self.galleryData)
            }
        })
    }

    private func onCellWillAppear(index: Int) {
        if galleryData[index].previewPhoto != nil {
            return
        }

        networkProvider?.photo(urlString: galleryFullData[index].galleryData.smallPhotoUrl) { [weak self] photo, error in
            guard let self = self else {
                return
            }

            DispatchQueue.main.async {
                guard error.isEmpty, let imageData = photo else {
                    self.rootView?.displayErrorState(error.isEmpty ? "Something went wrong!" : error)
                    return
                }

                self.galleryData[index] = .init(
                    name: self.galleryData[index].name,
                    previewPhoto: imageData.jpegData(compressionQuality: 0.9)
                )
                self.galleryFullData[index] = .init(
                    galleryData: self.galleryFullData[index].galleryData,
                    galleryLargePhoto: self.galleryFullData[index].galleryLargePhoto,
                    gallerySmallPhoto: photo
                )
                self.rootView?.updateCellData(with: self.galleryData[index], index: index)
            }
        }
    }

    private func onCellDidSelect(index: Int) {
        let photoUrl: String?
        let photoImage: UIImage?
        if let image = galleryFullData[index].galleryLargePhoto {
            photoImage = image
            photoUrl = nibName
        } else {
            photoImage = nil
            photoUrl = galleryFullData[index].galleryData.largePhotoUrl
        }

        router?.showLargePhoto(
            photo: photoUrl,
            photo: photoImage,
            completion: { [weak self] image in
                guard let self = self else {
                    return
                }

                self.galleryFullData[index] = .init(
                    galleryData: self.galleryFullData[index].galleryData,
                    galleryLargePhoto: image ?? self.galleryFullData[index].galleryLargePhoto,
                    gallerySmallPhoto: self.galleryFullData[index].gallerySmallPhoto
                )
            }
        )
    }

    // MARK: - Make

    private func makeCellsData(_ data: [GalleryItem]) -> [GalleryCellData] {
        data.map {
            GalleryCellData(name: $0.name, previewPhoto: nil)
        }
    }

    private func makeGalleryData(_ data: [GalleryItem]) -> [GalleryFullData] {
        data.map {
            GalleryFullData(galleryData: $0, galleryLargePhoto: nil, gallerySmallPhoto: nil)
        }
    }
}
