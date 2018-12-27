//
//  NSImage+Placeholder.swift
//  PlaceholderKit
//
//  Created by Simon Lee on 12/12/18.
//  Copyright © 2018 Shao Ping Lee. All rights reserved.
//

#if canImport(Cocoa)
import Cocoa

extension Placeholder {
    public func coloredBackground() -> Image? {
        let image = NSImage(size: size)
        let rect = CGRect(origin: .zero, size: size)

        image.lockFocus()

        // background
        switch backgroundStyle {
        case .solidColor(let color):
            color.drawSwatch(in: rect)
        default:
            break
        }

        // draw text
        displayedText.draw(in: textRect,
                           withAttributes: displayedTextAttributes)
        image.unlockFocus()
        return image
    }
}
#endif
