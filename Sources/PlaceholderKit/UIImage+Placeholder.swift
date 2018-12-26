//
//  UIImage+Placeholder.swift
//  PlaceholderKit
//
//  Created by Simon Lee on 12/12/18.
//  Copyright © 2018 Shao Ping Lee. All rights reserved.
//

#if canImport(UIKit)
import UIKit

extension UIImage {
    static func image(withColor color: UIColor, size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { context in
            let rect = CGRect(origin: .zero, size: size)
            // background
            color.setFill()
            context.fill(rect)

            // text style
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            let attrs = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 10)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]

            // display string
            let string = "\(Int(size.width))x\(Int(size.height))"

            // draw text
            string.draw(with: rect, options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        }

        return image
    }

}

#endif
