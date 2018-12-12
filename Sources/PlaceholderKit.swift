//
//  PlaceholderKit.swift
//  PlaceholderKit
//
//  Created by Simon Lee on 12/12/18.
//  Copyright © 2018 Shao Ping Lee. All rights reserved.
//

#if os(OSX)
import AppKit
typealias Color = NSColor
typealias Image = NSImage
#else
import UIKit
typealias Color = UIColor
typealias Image = UIImage
#endif

public struct PlaceholderFactory {
    let settings: PlaceholderSettings

    func createPlaceholder() -> Image? {
        switch settings.background {
        case .solidColor(let color):
            return Image.createPlaceholder(withColor: color, size: settings.size)
        case .image:
            return nil
        }
    }
}

public struct PlaceholderSettings {
    let size: CGSize
    let background: PlaceholderBackground
    let showDimensionAsText: Bool
    let convertDimensionToAspectRatio: Bool
}

enum PlaceholderBackground {
    case solidColor(Color)
    case image(Image)
}
