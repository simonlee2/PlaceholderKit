//
//  main.swift
//  ImagesExample-macOS
//
//  Created by Simon Lee on 12/26/18.
//
import PlaceholderKit
import Cocoa

let images = PlaceholderKit.defaultPlaceholders

let desktopURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!

images.enumerated().forEach { index, image in
    let fileURL = desktopURL.appendingPathComponent("placeholder-\(index).png")
    image.writePNG(toURL: fileURL)
}
