//
//  PhotosLibrary.swift
//  ImagesExample
//
//  Created by Simon Lee on 12/28/18.
//  Copyright © 2018 Shao Ping Lee. All rights reserved.
//

#if os(iOS)
import Foundation
import Photos

public class PhotosLibrary {
    enum Error: Swift.Error {
        case AlbumDNE
    }

    public static let albumName = "PlaceholderKit"

    public init() {}

    public func addImages(_ images: [Image]) throws {
        for image in images {
            try addImage(image)
        }
    }

    // Add image to thelibrary
    public func addImage(_ image: Image,
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

    public func fetchAlbum(title: String) -> PHFetchResult<PHAssetCollection> {
        // Fetch albums with title
        let options = PHFetchOptions()
        options.predicate = NSPredicate(format: "title = %@", title)
        let album = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: options)
        return album
    }

    public func performChanges(_ changeBlock: @escaping (PhotosLibrary) -> Void,
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
    public func createAlbum(title: String = albumName) {
        // Make sure album doesn't exist already
        let album = fetchAlbum(title: title)
        guard album.count == 0 else {
            return
        }

        // Create a new album with the entered title.
        PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: title)
    }

    // Remove the album the has the placeholders
    public func removeAlbum(title: String = albumName) {

        let album = fetchAlbum(title: title)

        // Delete
        album.enumerateObjects { (collection, _, _) in
            let assets = PHAsset.fetchAssets(in: collection, options: nil)
            PHAssetChangeRequest.deleteAssets(assets)
            PHAssetCollectionChangeRequest(for: collection)?.removeAssets(assets)
        }
    }
}
#endif
