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

public struct PlaceholderKit {
    public static let defaultPalette = ColorPalette(name: "defaultPalette",
                                             colors: [
                                                Color("ff5a5a"),
                                                Color("ff7b5a"),
                                                Color("ffb65a"),
                                                Color("ced07d"),
                                                Color("7dd0b6")
        ])

    public static let defaultSizes = [
        CGSize(width: 320, height: 320),
        CGSize(width: 320, height: 480),
        CGSize(width: 480, height: 320),
        CGSize(width: 320, height: 569),
        CGSize(width: 569, height: 320),
        ]

    public static var defaultPreset: RandomColorPreset {
        return RandomColorPreset(name: "defaultPreset",
                                 colorPalette: defaultPalette,
                                 sizes: defaultSizes)
    }

    public static var defaultPlaceholders: [Image] {
        return defaultPreset.placeholders.compactMap({$0.render()})
    }
}

public struct ColorPalette {
    let name: String
    let colors: [Color]

    var looper: LoopAroundIterator<Color> {
        return LoopAroundIterator(sequence: colors, current: 0)
    }

    public init(name: String, colors: [Color]) {
        self.name = name
        self.colors = colors
    }
}

public enum AspectRatio: CaseIterable {
    case r1x1
    case r2x3
    case r3x2
    case r4x5
    case r5x4
    case r9x16
    case r16x9

    var value: Double {
        switch self {
        case .r1x1:
            return 1.0
        case .r2x3:
            return 0.6666
        case .r3x2:
            return 1.5
        case .r4x5:
            return 0.8
        case .r5x4:
            return 1.25
        case .r9x16:
            return 0.5625
        case .r16x9:
            return 1.7778
        }
    }

    var displayString: String {
        switch self {
        case .r1x1:
            return "1:1"
        case .r2x3:
            return "2:3"
        case .r3x2:
            return "3:2"
        case .r4x5:
            return "4:5"
        case .r5x4:
            return "5:4"
        case .r9x16:
            return "9:16"
        case .r16x9:
            return "16:9"
        }
    }
}

public struct RandomColorPreset {
    let name: String
    let colorPalette: ColorPalette
    let sizes: [CGSize]

    public var placeholders: [Placeholder] {
        let colorSequence = AnySequence { self.colorPalette.looper }
        let placeholders = zip(sizes, colorSequence)
            .map({Placeholder(size: $0,
                              backgroundStyle: .solidColor($1))})
        return placeholders
    }

    public init(name: String,
                colorPalette: ColorPalette,
                sizes: [CGSize]) {
        self.name = name
        self.colorPalette = colorPalette
        self.sizes = sizes
    }
}

public struct LoopAroundIterator<T>: IteratorProtocol {
    let sequence: [T]
    var current = 0

    mutating public func next() -> T? {
        guard 0..<sequence.count ~= current else { return nil }

        let item = sequence[current]
        current = (current + 1) % sequence.count
        return item
    }
}

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

        let attrs = [
            NSAttributedString.Key.font: Font(name: "HelveticaNeue", size: 20)!,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]

        return attrs
    }

    public var displayedText: String {
        let pointSizeString = "\(Int(size.width))x\(Int(size.height))"

        // find nearest aspect ratio
        let ratio = size.width / size.height
        let nearestRatio = AspectRatio.allCases.first(where: {abs(CGFloat($0.value) - ratio) < 0.005})

        return [pointSizeString, nearestRatio?.displayString].compactMap({$0}).joined(separator: " | ")
    }

    public var textRect: CGRect {
        let attributedString = NSAttributedString(string: displayedText,
                                                  attributes: displayedTextAttributes)
        let textSize = attributedString.size()
        let rect =  CGRect(x: (size.width - textSize.width) / 2,
                           y: (size.height - textSize.height) / 2,
                           width: textSize.width,
                           height: textSize.height)
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

public extension Color {
    public convenience init(_ hexString: String, alpha: CGFloat = 1) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(255 * alpha) / 255)
    }
}
