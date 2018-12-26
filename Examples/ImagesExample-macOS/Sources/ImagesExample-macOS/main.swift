//
//  main.swift
//  ImagesExample-macOS
//
//  Created by Simon Lee on 12/26/18.
//
import PlaceholderKit
import Cocoa

let images = [
    PlaceholderBuilder().coloredBackground(color: .red,
                                           size: CGSize(width: 100, height: 100)),
    PlaceholderBuilder().coloredBackground(color: .blue,
                                           size: CGSize(width: 100, height: 200)),
    PlaceholderBuilder().coloredBackground(color: .green,
                                           size: CGSize(width: 200, height: 100)),
    PlaceholderBuilder().coloredBackground(color: .yellow,
                                           size: CGSize(width: 320, height: 480))
].compactMap({$0})

let desktopURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!

images.enumerated().forEach { index, image in
    let fileURL = desktopURL.appendingPathComponent("placeholder-\(index).png")
    image.writePNG(toURL: fileURL)
}
