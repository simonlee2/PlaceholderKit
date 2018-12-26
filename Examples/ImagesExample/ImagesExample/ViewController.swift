//
//  ViewController.swift
//  ImagesExample
//
//  Created by Simon Lee on 12/26/18.
//  Copyright © 2018 Shao Ping Lee. All rights reserved.
//

import UIKit
import PlaceholderKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = PlaceholderSettings(size: CGSize(width: 320, height: 640),
                                           background: .solidColor(UIColor.red),
                                           showDimensionAsText: true,
                                           convertDimensionToAspectRatio: false)
        let factory = PlaceholderFactory(settings: settings)
        let image = factory.createPlaceholder()
        print(image)
    }
}

