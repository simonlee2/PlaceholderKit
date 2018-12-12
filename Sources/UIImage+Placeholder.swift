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
    static func createPlaceholder(withColor color: UIColor, size: CGSize) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 1.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        return UIImage(cgImage: cgImage)
    }
}

#endif
