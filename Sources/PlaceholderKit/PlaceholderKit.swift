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

public struct Placeholder {
    let size: CGSize
    let backgroundStyle: BackgroundStyle

    public init(size: CGSize, backgroundStyle: BackgroundStyle) {
        self.size = size
        self.backgroundStyle = backgroundStyle
    }
}

public struct PlaceholderBuilder {
    public func coloredBackground(color: UIColor, size: CGSize) -> Image? {
        return Image.image(withColor: color, size: size)
    }

    public func imageBackground(image: UIImage, size: CGSize, tiled: Bool = false) -> Image? {
        return nil
    }

    public init() {}
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
