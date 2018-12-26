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
}

public struct PlaceholderBuilder {
    public func coloredBackground(color: Color, size: CGSize) -> Image? {
        return Image.image(withColor: color, size: size)
    }

    public func imageBackground(image: Image, size: CGSize, tiled: Bool = false) -> Image? {
        return nil
    }

    // not platform specific
    public func displayedTextAttributes() -> [NSAttributedString.Key: NSObject] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let attrs = [NSAttributedString.Key.font: Font(name: "HelveticaNeue", size: 10)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]

        return attrs
    }

    public func displayedText(size: CGSize) -> String {
        let string = "\(Int(size.width))x\(Int(size.height))"
        return string
    }

    public func textRect(imageSize: CGSize) -> CGRect {
        let attributedString = NSAttributedString(string: displayedText(size: imageSize),
                                                  attributes: displayedTextAttributes())
        let textSize = attributedString.size()
        let rect =  CGRect(x: 0,
                           y: (imageSize.height - textSize.height) / 2,
                           width: imageSize.width,
                           height: textSize.height)
        return rect

    }

    public init() {}
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
