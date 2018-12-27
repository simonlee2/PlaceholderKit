//
//  main.swift
//  ImagesExample-macOS
//
//  Created by Simon Lee on 12/26/18.
//
import PlaceholderKit
import Cocoa

let images = [
    Placeholder(size: CGSize(width: 100, height: 100), backgroundStyle: .solidColor(.red)),
    Placeholder(size: CGSize(width: 200, height: 100), backgroundStyle: .solidColor(.blue)),
    Placeholder(size: CGSize(width: 100, height: 200), backgroundStyle: .solidColor(.green)),
    Placeholder(size: CGSize(width: 320, height: 480), backgroundStyle: .solidColor(.yellow)),
].compactMap({$0.render()})

let desktopURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!

images.enumerated().forEach { index, image in
    let fileURL = desktopURL.appendingPathComponent("placeholder-\(index).png")
    image.writePNG(toURL: fileURL)
}
