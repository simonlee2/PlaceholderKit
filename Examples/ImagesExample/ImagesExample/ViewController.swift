//
//  ViewController.swift
//  ImagesExample
//
//  Created by Simon Lee on 12/26/18.
//  Copyright © 2018 Shao Ping Lee. All rights reserved.
//

import UIKit
import PlaceholderKit
import Photos

class ViewController: UIViewController {
    var sampleImagesCollectionViewController: SampleImagesCollectionViewController?

    let images: [UIImage] = PlaceholderKit.defaultPlaceholders
    let photosLibary = PhotosLibrary()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Placeholders"
        view.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
        setupCollectionViewController()
    }

    func setupCollectionViewController() {
        let controller = SampleImagesCollectionViewController(data: images)
        guard let collectionView = controller.view else { return }

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        sampleImagesCollectionViewController = controller

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }

    func insertImagesIntoPhotos(completionHandler: ((Bool, Error?) -> Void)? = nil) {
        photosLibary.performChanges({ library in
            library.createAlbum()
            try? library.addImages(self.images)
        }, completionHandler: completionHandler)
    }

    func removeAlbum(completionHandler: ((Bool, Error?) -> Void)? = nil) {
        photosLibary.performChanges({ library in
            library.removeAlbum()
        }, completionHandler: completionHandler)
    }
}

class SampleImagesCollectionViewController: UICollectionViewController {
    let data: [UIImage]

    init(data: [UIImage]) {
        self.data = data
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: 200, height: 200)
        layout.scrollDirection = .vertical

        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(SampleImageCollectionViewCell.self, forCellWithReuseIdentifier: SampleImageCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SampleImageCollectionViewCell.reuseIdentifier,
                                                      for: indexPath)

        guard let castedCell = cell as? SampleImageCollectionViewCell else {
            return cell
        }

        castedCell.imageView.image = data[indexPath.row]

        return castedCell
    }
}

class SampleImageCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "SampleImagesCell"

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

