//
//  ViewController.swift
//  ImagesExample
//
//  Created by Simon Lee on 12/26/18.
//  Copyright © 2018 Shao Ping Lee. All rights reserved.
//

import UIKit
import PlaceholderKit

class ViewController: UIViewController {
    var sampleImagesCollectionViewController: SampleImagesCollectionViewController?

    let images: [UIImage] = PlaceholderKit.defaultPlaceholders
    let photosLibary = PhotosLibrary()

    // Views
    let containerView = UIView()
    let saveToPhotosButton: UIButton = UIButton(type: .system)
    let removeFromPhotosButton: UIButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Placeholders"
        view.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
        setupButtonContainerView()
        setupCollectionViewController()
        setupButtons()
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
            collectionView.bottomAnchor.constraint(equalTo: containerView.topAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }

    func setupButtonContainerView() {
        containerView.backgroundColor = UIColor("#fafafa")
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 140)
        ])
    }

    func setupButtons() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(saveToPhotosButton)
        stackView.addArrangedSubview(removeFromPhotosButton)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor),
        ])

        saveToPhotosButton.setTitle("Save to Photos", for: .normal)
        removeFromPhotosButton.setTitle("Remove from Photos", for: .normal)
        
        saveToPhotosButton.addTarget(self, action: #selector(insertImagesIntoPhotos),
                                     for: .touchUpInside)
        removeFromPhotosButton.addTarget(self, action: #selector(removeAlbum),
                                         for: .touchUpInside)
    }

    @objc func insertImagesIntoPhotos() {
        photosLibary.performChanges({ library in
            library.createAlbum()
        }, completionHandler: { success, error in
            if success {
                self.photosLibary.performChanges({ library in
                    try? library.addImages(self.images)
                })
            }
        })
    }

    @objc func removeAlbum() {
        photosLibary.performChanges({ library in
            library.removeAlbum()
        })
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

