//
//  PlaceholderKit.swift
//  PlaceholderKit
//
//  Created by Simon Lee on 12/12/18.
//  Copyright © 2018 Shao Ping Lee. All rights reserved.
//

#if os(OSX)
import AppKit
public typealias Color = NSColor
public typealias Image = NSImage
#else
import UIKit
public typealias Color = UIColor
public typealias Image = UIImage
#endif

public struct PlaceholderFactory {
    let settings: PlaceholderSettings

    public func createPlaceholder() -> Image? {
        switch settings.background {
        case .solidColor(let color):
            return Image.createPlaceholder(withColor: color, size: settings.size)
        case .image:
            return nil
        }
    }

    public init(settings: PlaceholderSettings) {
        self.settings = settings
    }
}

public struct PlaceholderSettings {
    let size: CGSize
    let background: BackgroundStyle
    let showDimensionAsText: Bool
    let convertDimensionToAspectRatio: Bool

    public init(size: CGSize,
                background: BackgroundStyle,
                showDimensionAsText: Bool,
                convertDimensionToAspectRatio: Bool) {
        self.size = size
        self.background = background
        self.showDimensionAsText = showDimensionAsText
        self.convertDimensionToAspectRatio = convertDimensionToAspectRatio
    }
}

public enum BackgroundStyle {
    case solidColor(Color)
    case image(Image)
}
