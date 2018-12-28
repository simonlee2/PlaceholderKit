//
//  PhotosLibrary.swift
//  ImagesExample
//
//  Created by Simon Lee on 12/28/18.
//  Copyright © 2018 Shao Ping Lee. All rights reserved.
//

import Foundation
import Photos

class PhotosLibrary {
    enum Error: Swift.Error {
        case AlbumDNE
    }

    static let albumName = "PlaceholderKit"

    func addImages(_ images: [UIImage]) throws {
        for image in images {
            try addImage(image)
        }
    }

    // Add image to thelibrary
    func addImage(_ image: UIImage,
                  toAlbumNamed title: String = albumName) throws {
        guard let album = fetchAlbum(title: title).firstObject else {
            throw Error.AlbumDNE
        }

        let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
        let assetPlaceHolder = assetChangeRequest.placeholderForCreatedAsset
        let albumChangeRequest = PHAssetCollectionChangeRequest(for: album)
        let enumeration = [assetPlaceHolder].compactMap({$0}) as NSArray
        albumChangeRequest?.addAssets(enumeration)
    }

    func fetchAlbum(title: String) -> PHFetchResult<PHAssetCollection> {
        // Fetch albums with title
        let options = PHFetchOptions()
        options.predicate = NSPredicate(format: "title = %@", title)
        let album = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: options)
        return album
    }

    func performChanges(_ changeBlock: @escaping (PhotosLibrary) -> Void,
                        completionHandler: ((Bool, Swift.Error?) -> Void)? = nil) {
        ensurePhotoLibaryAuthorized { (library) in
            PHPhotoLibrary.shared().performChanges({
                changeBlock(library)
            }, completionHandler: completionHandler)
        }
    }

    func ensurePhotoLibaryAuthorized(authorizedHandler: @escaping (PhotosLibrary) -> Void) {
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            authorizedHandler(self)
            return
        }

        PHPhotoLibrary.requestAuthorization { _ in
            authorizedHandler(self)
        }
    }

    // Create an album for placeholders
    func createAlbum(title: String = albumName) {
        // Make sure album doesn't exist already
        let album = fetchAlbum(title: title)
        guard album.count == 0 else {
            return
        }

        // Create a new album with the entered title.
        PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: title)
    }

    // Remove the album the has the placeholders
    func removeAlbum(title: String = albumName) {

        let album = fetchAlbum(title: title)

        // Delete
        album.enumerateObjects { (collection, _, _) in
            let assets = PHAsset.fetchAssets(in: collection, options: nil)
            PHAssetChangeRequest.deleteAssets(assets)
            PHAssetCollectionChangeRequest(for: collection)?.removeAssets(assets)
        }
    }
}
