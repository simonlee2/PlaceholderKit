//
//  NSImage+PNG.swift
//  ImagesExample-macOS
//
//  Created by Simon Lee on 12/26/18.
//

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
