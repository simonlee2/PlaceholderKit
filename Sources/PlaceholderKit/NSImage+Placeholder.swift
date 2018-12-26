//
//  NSImage+Placeholder.swift
//  PlaceholderKit
//
//  Created by Simon Lee on 12/12/18.
//  Copyright © 2018 Shao Ping Lee. All rights reserved.
//

#if canImport(Cocoa)
import Cocoa

extension NSImage {
    static func image(withColor color: NSColor, size: CGSize) -> NSImage? {
        let image = NSImage(size: size)
        let rect = CGRect(origin: .zero, size: size)

        image.lockFocus()

        // background
        color.drawSwatch(in: rect)

        // text
        let text = PlaceholderBuilder().displayedText(size: size)
        let attrs = PlaceholderBuilder().displayedTextAttributes()
        let textRect = PlaceholderBuilder().textRect(imageSize: size)

        // draw text
        text.draw(in: textRect, withAttributes: attrs)
        image.unlockFocus()
        return image
    }
}

#endif
