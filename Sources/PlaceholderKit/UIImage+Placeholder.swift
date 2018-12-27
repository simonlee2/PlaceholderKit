//
//  UIImage+Placeholder.swift
//  PlaceholderKit
//
//  Created by Simon Lee on 12/12/18.
//  Copyright © 2018 Shao Ping Lee. All rights reserved.
//

#if canImport(UIKit)
import UIKit

extension Placeholder {
     public func coloredBackground() -> Image? {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { context in
            let rect = CGRect(origin: .zero, size: size)

            // background
            switch backgroundStyle {
            case .solidColor(let color):
                color.setFill()
                context.fill(rect)
            default:
                break
            }

            // draw text
            displayedText.draw(with: textRect,
                               options: .usesLineFragmentOrigin,
                               attributes: displayedTextAttributes,
                               context: nil)
        }

        return image
    }
}

#endif
