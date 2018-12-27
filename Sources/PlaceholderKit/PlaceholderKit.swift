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
public typealias Font = NSFont
#else
import UIKit
public typealias Color = UIColor
public typealias Image = UIImage
public typealias Font = UIFont
#endif

public struct Placeholder {
    let size: CGSize
    let backgroundStyle: BackgroundStyle

    public init(size: CGSize, backgroundStyle: BackgroundStyle) {
        self.size = size
        self.backgroundStyle = backgroundStyle
    }

    // not platform specific
    public var displayedTextAttributes: [NSAttributedString.Key: NSObject] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let attrs = [NSAttributedString.Key.font: Font(name: "HelveticaNeue", size: 20)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]

        return attrs
    }

    public var displayedText: String {
        return "\(Int(size.width))x\(Int(size.height))"
    }

    public var textRect: CGRect {
        let attributedString = NSAttributedString(string: displayedText,
                                                  attributes: displayedTextAttributes)
        let textSize = attributedString.size()
        let rect =  CGRect(x: 0,
                           y: (size.height - textSize.height) / 2,
                           width: size.width,
                           height: size.height)
        return rect
    }

    public func render() -> Image? {
        return coloredBackground()
    }
}

public enum BackgroundStyle {
    case solidColor(Color)
    case image(Image)
}

public enum BackgroundStrategy {
    case randomColor
    case randomImage
}

public enum TextLocationStrategy {
    case center
    case topRight
    case topLeft
    case bottomRight
    case bottomLeft
}

public enum TextSizeFormatStrategy {
    case points
    case aspectRatio
}
