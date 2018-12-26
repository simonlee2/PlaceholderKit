//
//  main.swift
//  ImagesExample-macOS
//
//  Created by Simon Lee on 12/26/18.
//
import PlaceholderKit
import Cocoa

public extension NSImage {
    public func writePNG(toURL url: URL) {

        guard let data = tiffRepresentation,
            let rep = NSBitmapImageRep(data: data),
            let imgData = rep.representation(using: .png, properties: [.compressionFactor : NSNumber(floatLiteral: 1.0)]) else {

                print("\(self.self) Error Function '\(#function)' Line: \(#line) No tiff rep found for image writing to \(url)")
                return
        }

        do {
            try imgData.write(to: url)
        } catch let error {
            print("\(self.self) Error Function '\(#function)' Line: \(#line) \(error.localizedDescription)")
        }
    }
}

let image = PlaceholderBuilder().coloredBackground(color: .red, size: CGSize(width: 100, height: 100))

let desktopURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
let fileURL = desktopURL.appendingPathComponent("placeholder.png")

image?.writePNG(toURL: fileURL)
